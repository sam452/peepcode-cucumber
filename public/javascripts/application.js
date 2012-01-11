

jQuery(function () {

  if ($('#diagram').length > 0) {
    var width = $("#diagram").width(),
      height = $("#diagram").height(),
      paper = Raphael("diagram", width, height),
      nicksURL;

    app.init(paper, width, height);
    app.handleClicks(paper);
    app.getNicks(paper);
  }
});

  // Helpers & Duck Punches

  var Path = {
    plus: function (cx, cy, r) {
      r = r ? r : 20;
      return "M {cx} {cy} m -{startX} -{startY} l {r} 0 l 0 {r} l {r} 0 l 0 {r} l -{r} 0 l 0 {r} l -{r} 0 l 0 -{r} l -{r} 0 l 0 -{r} l {r} 0 z".supplant({
        cx: cx,
        cy: cy,
        r: r,
        startX: r/2,
        startY: r/2 + r
      });
    },
    face: function (cx, cy, r) {
      r = r ? r : 75;
      return "M {cx} {cy} m -{r} -{rthreequart} a {r} {r} 0 1 1 {rdoub} 0 l 0 {r}  a {r} {r} 0 1 1 -{rdoub} 0".supplant({
        cx: cx,
        cy: cy,
        r: r,
        rdoub: r*2,
        rhalf: r/2,
        rthreequart: r*(3/4)
      });
    }
  };


  var app = {

    init: function (paper, width, height) {
      this.drawFace(paper, width, height);
    },

    handleClicks: function(paper) {
      $("#diagram").click(function (evt) {
        app.clickedDiagram(paper, this, evt);
      });
    },

    getNicks: function (paper) {
      nicksURL = "/nicks/" + window.location.pathname.split(/\//)[2] + ".json?callback=?";
      $.getJSON(nicksURL, function (data, textStatus) {
        jQuery.each(data, function () {
          app.drawNick(paper, this[0], this[1]);
        });
      });
    },

    drawFace: function (paper, width, height) {
      paper.path(Path.face(width/2, height/2)).attr({
        fill: "white",
        "fill-opacity": 0.5,
        "stroke-width": 0
      });
    },

    drawNick: function (paper, cx, cy) {
      var radius = 5;
      paper.path(Path.plus(cx, cy, radius)).attr({
        stroke: "white",
        fill: "red",
        "fill-opacity": 1,
        "stroke-width": 1,
        "stroke-opacity": 0.5
      });
    },

    clickedDiagram: function (paper, element, evt) {
      var localX, localY, nicksURL;

      localX = evt.pageX - element.offsetLeft;
      localY = evt.pageY - element.offsetTop;

      nicksURL = "/nicks/" + window.location.pathname.split(/\//)[2] + ".json";

      $.put(nicksURL, {x: localX, y: localY});
      this.drawNick(paper, localX, localY);
    }

  };

  jQuery.extend({
    put: function( url, data, callback, type ) {
      // shift arguments if data argument was omited
      if ( jQuery.isFunction( data ) ) {
        type = type || callback;
        callback = data;
        data = {};
      }

      return jQuery.ajax({
        type: "PUT",
        url: url,
        data: data,
        success: callback,
        dataType: type
      });
    }
  });

  // "{animal} on a {transport}".supplant({animal: "frog", transport: "rocket"})
  String.prototype.supplant = function (o) {
    return this.replace(/\{([^{}]*)\}/g,
                        function (a, b) {
                          var r = o[b];
                          return typeof r === 'string' || typeof r === 'number' ? r : a;
                        }
                       );
  };


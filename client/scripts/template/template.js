module.exports = (function (React) {
  var jade_globals_tick = typeof tick === "undefined" ? undefined : tick;
  var jade_globals_count = typeof count === "undefined" ? undefined : count;
  var fn = function(locals) {  var tick = "tick" in locals ? locals.tick : jade_globals_tick;
    var count = "count" in locals ? locals.count : jade_globals_count;
    return function() {
      var tags = [];
      tags.push(React.createElement.apply(React, [ "div", {
        id: "counter"
      } ].concat(function() {
        return [ React.createElement.apply(React, [ "span", {} ].concat(function() {
          return [ "Count :" ];
        }.call(this))), React.createElement.apply(React, [ "button", {
          onClick: tick,
          className: "btn"
        } ].concat(function() {
          return [ count ];
        }.call(this))) ];
      }.call(this))));
      if (1 === tags.length) return tags.pop();
      tags.unshift("div", null);
      return React.createElement.apply(React, tags);
    }.call(this);
  };;
  fn.locals = function setLocals(locals) {
    var render = this;
    function newRender(additionalLocals) {
      var newLocals = {};
      for (var key in locals) {
        newLocals[key] = locals[key];
      }
      if (additionalLocals) {
        for (var key in additionalLocals) {
          newLocals[key] = additionalLocals[key];
        }
      }
      return render.call(this, newLocals);
    }
    newRender.locals = setLocals;
    return newRender;
  }
  ;
  return fn;
}(typeof React !== "undefined" ? React : require("react")))
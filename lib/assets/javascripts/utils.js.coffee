

Utils = (-> 

  # From http://stackoverflow.com/a/3745677/2302781
  hex2a = (hexx)->
    hex = hexx.toString(); #force conversion
    str = '';
    for i in [0..hex.length] by 2
      str += String.fromCharCode(parseInt(hex.substr(i, 2), 16))
    return str;

  publicFunctions = 
    hex2a: hex2a

  return publicFunctions
)()

window.Utils = Utils
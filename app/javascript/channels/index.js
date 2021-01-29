// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

function pullDown() {

  const pullDownButton = document.getElementById("lists")
  const pullDownParents = document.getElementById("pull-down")
  
    pullDownButton.addEventListener('mouseover', function(){
      this.setAttribute("style", "background-color:#FFBEDA;")
    })
  
    pullDownButton.addEventListener('mouseout', function(){
      this.removeAttribute("style", "background-color:#FFBEDA;")
    })
  
    pullDownButton.addEventListener('click', function() {
      // プルダウンメニューの表示と非表示の設定
      if (pullDownParents.getAttribute("style") == "display:block;") {
        // pullDownParentsにdisplay:block;が付与されている場合（つまり表示されている時）実行される
        pullDownParents.removeAttribute("style", "display:block;")
      } else {
        // pullDownParentsにdisplay:block;が付与されていない場合（つまり非表示の時）実行される
        pullDownParents.setAttribute("style", "display:block;")
      }
    })
  }

window.addEventListener('load', pullDown)
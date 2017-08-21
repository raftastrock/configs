AUI().ready(
  'pop-up',
  function (A) {
    var activateCallback = function (classToggleInstance, node, targetNodes, targetClass) {
      if (node.attr('data-embed')) {
        var videoId = node.attr('data-embed');

        var nodeContent = '<iframe allowfullscreen="true" frameborder="0" height="450" src="//www.youtube.com/embed/' + videoId + '?wmode=transparent&autoplay=1&controls=0&showinfo=0&rel=0" width="100%"></iframe>';

        var targetNodesContent = targetNodes.one('.' + classToggleInstance.get('baseClassName') + '-content');

        if (targetNodesContent) {
          targetNodesContent.setContent(nodeContent);
        }
      }
    };

    var deactivateCallback = function (classToggleInstance, node, targetNodes, targetClass) {
      var targetNodesContent = targetNodes.one('.' + classToggleInstance.get('baseClassName') + '-content');

      if (targetNodesContent) {
        targetNodesContent.empty();
      }
    }

    new A.PopUp(
      {
        activateCallback: activateCallback,
        deactivateCallback: deactivateCallback,
        defaultCallbacks: false,
        overlayCssClass: ' video-overlay'
      }
    ).render();

    console.log('hello')
  }
);
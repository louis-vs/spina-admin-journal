//= require jquery
//= require jquery_ujs
//= require spina/admin/journal/html5sortable
/* global sortable */

// TODO: rewrite this as a Stimulus controller so that it correctly loads when
// and only when needed.
$(document).on('turbo:load', () => {
  // html5sortable configuration
  sortable('.html5sortable', {
    items: 'tr',
    itemSerializer: (serializedItem) => {
      return {
        position: serializedItem.index + 1,
        id: serializedItem.node.getAttribute('data-id')
      };
    },
    containerSerializer: (serializedContainer) => {
      return {
        name: serializedContainer.node.getAttribute('data-sorted-collection')
      };
    }
  });

  // add sorting event listener if there is a sortable container on the page
  if(typeof sortable('.html5sortable')[0] !== 'undefined') {
    sortable('.html5sortable')[0].addEventListener('sortupdate', e => {
      let container = e.detail.destination.container;
      let serialized = sortable('.html5sortable', 'serialize')[0];
      let data = serialized.items.reduce((map, obj) => {
        map[`${serialized.container.name}[list[${obj.id}]]`] = obj.position;
        return map;
      }, {});

      let displayError = (...args) => {
        let message = 'An unknown error occured.'; // not translateable (but should never happen)
        if(typeof args[0] === 'string') {
          message = args[0];
        }
        // display error message
        $('.sort-message').html('');
        $('.sort-message').removeClass('animate-fadein success');
        $('.sort-message').width(); // trigger reflow
        $('.sort-message').html(message).addClass('error animate-fadein');
        // TODO: return element to its origin
        // this needs to be done manually, but may not really be necessary since the displayed
        // numbers won't change
      };

      // send sort request
      $.ajax({
        type: 'PATCH',
        url: $('.html5sortable').eq(0).data('sort-url'),
        beforeSend: $.rails.CSRFProtection,
        dataType: 'json',
        data: data,
        success: (data) => {
          if(data.success) {
            // display success message
            $('.sort-message').html(''); // clear message
            $('.sort-message').removeClass('animate-fadein error');
            $('.sort-message').width(); // trigger reflow (for animation to work)
            $('.sort-message').html(data.message).addClass('success animate-fadein');
            // update displayed position number
            // NB this is done entirely clientside, so there is the potential for desync
            for(let i = 0; i < container.children.length; i++) {
              container.children[i].getElementsByClassName('position-display')[0].innerHTML = (i+1).toString();
            }
          } else {
            displayError(data.message);
          }
        },
        error: displayError
      });
    });
  }
});


// For search button
function searchToggle(obj, evt){
    var container = $(obj).closest('.search-wrapper');
    if(!container.hasClass('active')){
        container.addClass('active');
        evt.preventDefault();
    }
    else if(container.hasClass('active') && container.length === 0){
        container.removeClass('active');
    }
};

$('.file').change(function() {
    $('.fileTitle').text($(this)[0].files.item(0).name);
});




$('#<%= "comment_#{@comment.id}" %>').fadeOut("normal",function(){
        $(this).remove();
    })
$('#comments > h2').html('This article has <%= escape_javascript(pluralize(@post.comments.count, 'comment')) %>');

<%= render 'notification', formats: [:js] %>

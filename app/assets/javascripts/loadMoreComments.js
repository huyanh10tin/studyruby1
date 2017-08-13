// $( document ).ready(function() {
//     $('.more-comments').click( function() {
//         // alert("ok roi day");
//
//         $(this).on('ajax:success', function(event, data, status, xhr) {
//             event.preventDefault();
//             var postId = $(this).data("post-id");
//
//             $("#comments_" + postId).html(data);
//
//             $("#comments-paginator-" + postId).html("<a id='more-comments' data-post-id=" + postId + " data-type='html' data-remote='true' href='/posts/" + postId + "/comments'>show more comments</a>");
//             console.log("<a id='more-comments' data-post-id=" + postId + " data-type='html' data-remote='true' href='/posts/" + postId + "/comments'>show more comments</a>");
//         });
//     });
// });
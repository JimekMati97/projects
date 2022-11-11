const postComments=document.querySelector(".comments")

function Comment(){
    visible=false
}

let comment=new Comment()


const commentsRoller=document.querySelectorAll(".commentsTag")

commentsRoller.forEach(element => {
    element.addEventListener("click",function(e){
    
        e.preventDefault()
        let postId="#"+String(e.target.parentNode.parentNode.parentNode.parentNode.id)
        const post=document.querySelector(postId)
        const comments=post.querySelector(".comments")

        if (comment.visible){
            comments.style.visibility="hidden"
            comments.style.display="none"
            comment.visible=false
        }else{
            comments.style.visibility="visible"
            comments.style.display="block"
            comment.visible=true
        }
    
    
        
    })
});   
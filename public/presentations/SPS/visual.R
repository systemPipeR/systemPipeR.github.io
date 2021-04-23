#### Make html picture link #####

make_html_picture_link <- function(path,
                                   link,
                                   title = stringr::str_remove(link, "\\..+")){
  
  cat(paste0('<a href="', link,
             '"><img src="', path,
             '"width="150" height="150" title=' ,
             title, ' alt=', path,'></a>'))
  
}

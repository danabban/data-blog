library(blogdown)
library(rstudioapi)

blogdown::serve_site()
blogdown::check_site()


rstudioapi::navigateToFile("config.yaml")


blogdown::build_site(build_rmd = "newfile")

blogdown::new_post(title = "My first post",
                   ext = '.Rmarkdown',
                   subdir = "post")


blogdown::stop_server()

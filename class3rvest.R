library(rvest)

ribalta <- read_html('data/ribalta.html')

ribalta %>% 
    html_nodes('ul') %>% 
    html_nodes('li') %>% 
    html_nodes('.street') %>% 
    html_text

super <- read_html(
    'https://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/'
)

super %>%
    html_nodes('table') %>% 
    html_table(header=FALSE)

ribalta %>% 
    html_nodes('#latitude') %>% 
    html_attr('value') %>% 
    as.numeric()

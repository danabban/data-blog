---
title: My first post
author: 'dubdee'
date: '2022-02-12'
slug: my-first-post
categories: [test]
tags: [test]
subtitle: ''
summary: ''
authors: [udubee]
lastmod: '2022-02-12T12:16:50Z'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: [test]
---


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 4.0.5
```

```r
x = seq(-1, 1, .01)
y = sin(x^3)/(1 + x^6)

ggplot(mapping = aes(x = x, 
                     y = y)) +
geom_line() +
geom_ribbon(aes(ymin = 0, 
                ymax = y), 
            fill = "pink", 
            alpha = 0.5) +
theme_void() 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-1-1.png" width="672" />


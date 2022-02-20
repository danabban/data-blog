---
title: Association Rules For Effective Product Recommendation
author: ''
date: '2022-02-20'
slug: product-recommendation
categories: [Business]
tags: [Business, DataScience]
subtitle: ''
summary: ''
authors: [Daniel Abban]
lastmod: '2022-02-20T19:19:52Z'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---


On Amazon's product page, users are presented with related products, under the heading **"Frequently bought together"** and **Customers who bought this item also bought**. 

Knowing what your customers tend to buy together can help with marketing efforts and cause you to optimize your store's layout for conversion.

There are several algorithmic implementations for the phenomenon described above, one we would be exploring in this example is the **apriori** algorithm.

In simple language, the algorithm is used to find frequent patterns in a database, in the example we would be looking at, the algorithm would tell us what items customers frequently buy together by generating a set of rules called **Association Rules**.

Observe the image below. Each ID shows the items bought in that transaction. You can see that **Diaper is bought with Beer in three transactions**.
![rules](rules.png)

Before we talk further on how the algorithm works, lets quickly take a glance at the data we would be using for this example:

#### The Dataset

We would explore data from an online grocery store. The table below shows the first 5 observations and contains two variables:

1.**orderID**:  A unique ID that represents the all the items purchased for each transaction 

2.**Product**: A description of the actual items that were bought.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> OrderID </th>
   <th style="text-align:left;"> Product </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 837080 </td>
   <td style="text-align:left;"> Unsweetened Almondmilk </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 837080 </td>
   <td style="text-align:left;"> Fat Free Milk </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 837080 </td>
   <td style="text-align:left;"> Turkey </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 837080 </td>
   <td style="text-align:left;"> Caramel Corn Rice Cakes </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 837080 </td>
   <td style="text-align:left;"> Guacamole Singles </td>
  </tr>
</tbody>
</table>






Which products are the most frequent in the data set, lets explore the top 5:

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Product </th>
   <th style="text-align:right;"> ProductCount </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Banana </td>
   <td style="text-align:right;"> 1458 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bag of Organic Bananas </td>
   <td style="text-align:right;"> 1138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Organic Strawberries </td>
   <td style="text-align:right;"> 910 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Organic Baby Spinach </td>
   <td style="text-align:right;"> 809 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Organic Hass Avocado </td>
   <td style="text-align:right;"> 730 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Organic Avocado </td>
   <td style="text-align:right;"> 602 </td>
  </tr>
</tbody>
</table>

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-3-1.png" width="672" />
We can see from the table and chat above that Banana is the most frequently occurring product across 1,456 transactions. 

Now, let's get back to how the **apriori** algorithm works

The Apriori algorithm requires two parameters from the user, named, **support** and **confidence** from the user

**Support** refers to the products’ frequency of occurrence. For example, if we set the support as 0.1, the algorithm calculates the transaction frequency for each product and discards all items that falls below 10 percent. 

**Confidence** is the ratio of the number of transactions that include all items in the consequent. I explain the meaning of these definitions with the example below:

> Red Vine Tomato => Banana[Support=20%,confidence=60%]

###### The above rule states:
1. 20% transactions shows that banana is bought with Red Vine Tomato 
2. 60% of customers who bought banana also bought Red Vine Tomato


#### A Summary of How the Algorithm Works

1. Finds frequent itemset in the database.
2. Calculates the support for every item.
3. If support is less than minimum support set by the user, discards the item. Else, inserts it into the list of frequent itemset.
4. Calculates the confidence for each non- empty subset.
5. If confidence is less than minimum confidence set by the user, discard the subset. Else, insert it into the list of strong rules.

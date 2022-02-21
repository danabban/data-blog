---
title: Frequent Itemset Analysis
author: ''
date: '2022-02-20'
slug: product-recommendation
categories: [Business]
tags: [Business, Analytics]
subtitle: ''
summary: ''
authors: [Daniel Abban]
lastmod: '2022-02-20T19:19:52Z'
featured: no
image:
  caption: 'Photo by Anna Shvets from Pexels'
  focal_point: ''
  preview_only: no
projects: [Analytics]
---

<script src="{{< blogdown/postref >}}index_files/htmlwidgets/htmlwidgets.js"></script>
<link href="{{< blogdown/postref >}}index_files/vis/vis-network.min.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index_files/vis/vis-network.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/visNetwork-binding/visNetwork.js"></script>

On Amazon’s product page, users are presented with related products, under the heading **“Frequently bought together”** and **Customers who bought this item also bought**.

Knowing what your customers tend to buy together can help with marketing efforts and cause you to optimize your store’s layout for conversion.

There are several algorithmic implementations for the phenomenon described above, the one we would be exploring in this example is the apriori algorithm.

In simple language, the algorithm is used to find frequent patterns in a database, in this example, the algorithm would tell us what items customers frequently buy together by generating a set of rules called **Association Rules**.

Observe the image below. Each ID shows the items bought in that transaction. You can see that **Diaper is bought with Beer in three transactions**.

{Diapers} –> {Beer} is an example of an association rule

![rules](rules.png)

The Apriori algorithm requires two parameters from the user: support and confidence

-   **Support** refers to the products’ frequency of occurrence. For example, if we set the support as 0.1, the algorithm calculates the transaction frequency for each product and discards all items that falls below 10 percent.

-   **Confidence** is the proportion of transactions with item X, in which item Y also appears.

Observe the example below to understand the algorithm’s parameters:

> Diapers => Beer\[Support=20%,confidence=60%\]

The above rule states:
1. 20% transactions shows that Beer is bought with Diapers
2. 60% of customers who bought Beer also bought Diapers

<br />

#### Example Dataset

Our data is from an online grocery store. The table below shows the first 5 observations:

1.orderID: A unique ID that represents the all the items purchased for each transaction

2.Product: A description of the actual items that were bought.

<table>
<thead>
<tr>
<th style="text-align:left;">
OrderID
</th>
<th style="text-align:left;">
Product
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
837080
</td>
<td style="text-align:left;">
Unsweetened Almondmilk
</td>
</tr>
<tr>
<td style="text-align:left;">
837080
</td>
<td style="text-align:left;">
Fat Free Milk
</td>
</tr>
<tr>
<td style="text-align:left;">
837080
</td>
<td style="text-align:left;">
Turkey
</td>
</tr>
<tr>
<td style="text-align:left;">
837080
</td>
<td style="text-align:left;">
Caramel Corn Rice Cakes
</td>
</tr>
<tr>
<td style="text-align:left;">
837080
</td>
<td style="text-align:left;">
Guacamole Singles
</td>
</tr>
</tbody>
</table>

Which products are the most frequent in the data set? lets explore:

<table>
<thead>
<tr>
<th style="text-align:left;">
Product
</th>
<th style="text-align:right;">
ProductCount
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Banana
</td>
<td style="text-align:right;">
1458
</td>
</tr>
<tr>
<td style="text-align:left;">
Bag of Organic Bananas
</td>
<td style="text-align:right;">
1138
</td>
</tr>
<tr>
<td style="text-align:left;">
Organic Strawberries
</td>
<td style="text-align:right;">
910
</td>
</tr>
<tr>
<td style="text-align:left;">
Organic Baby Spinach
</td>
<td style="text-align:right;">
809
</td>
</tr>
<tr>
<td style="text-align:left;">
Organic Hass Avocado
</td>
<td style="text-align:right;">
730
</td>
</tr>
<tr>
<td style="text-align:left;">
Organic Avocado
</td>
<td style="text-align:right;">
602
</td>
</tr>
</tbody>
</table>

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-2-1.png" width="672" />

We can see from the table and chat above that Banana is the most frequent occurring product, across 1,456 transactions.

<br />
<br />

###### A Summary of How the Algorithm Works

-   Finds frequent itemset in the database.
-   Calculates the support for every item.
-   If support is less than minimum support set by the user, discards the item. Else, inserts it into the list of frequent itemset.
-   Calculates the confidence for each non- empty subset.
-   If confidence is less than minimum confidence set by the user, discard the subset. Else, insert it into the list of strong rules.

<br />

##### Generate a list of frequent itemset

The algorithm makes multiple passes into the database; **in the first pass**, the algorithm calculates the transaction frequency for each product and discard all those itemsets that fall below our support threshold. At this stage, we have **order 1 itemsets**.

**In the second pass**, the algorithm takes the itemset from the first pass, construct a new 2-products itemsets and calculates their transaction frequency. Once again, it discards the itemsets that fall below the given support threshold. At this stage, we have **order 2 itemsets**

We stop when we reach a stage where we cannot create higher order itemsets.

Let us examine some frequent itemset generated from our data

<table>
<thead>
<tr>
<th style="text-align:left;">
item_set
</th>
<th style="text-align:right;">
support.support
</th>
<th style="text-align:right;">
support.count
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
{Banana,Red Vine Tomato}
</td>
<td style="text-align:right;">
0.0103034
</td>
<td style="text-align:right;">
72
</td>
</tr>
<tr>
<td style="text-align:left;">
{Bag of Organic Bananas,Organic D’Anjou Pears}
</td>
<td style="text-align:right;">
0.0100172
</td>
<td style="text-align:right;">
70
</td>
</tr>
<tr>
<td style="text-align:left;">
{Bag of Organic Bananas,Organic Kiwi}
</td>
<td style="text-align:right;">
0.0101603
</td>
<td style="text-align:right;">
71
</td>
</tr>
<tr>
<td style="text-align:left;">
{Banana,Organic Gala Apples}
</td>
<td style="text-align:right;">
0.0107327
</td>
<td style="text-align:right;">
75
</td>
</tr>
<tr>
<td style="text-align:left;">
{Banana,Yellow Onions}
</td>
<td style="text-align:right;">
0.0130223
</td>
<td style="text-align:right;">
91
</td>
</tr>
<tr>
<td style="text-align:left;">
{Banana,Seedless Red Grapes}
</td>
<td style="text-align:right;">
0.0130223
</td>
<td style="text-align:right;">
91
</td>
</tr>
</tbody>
</table>

<br />
<br />

#### Find Stong Rules

Similar to support, the confidence threshold is also provided by the user. Only those rules whose confidence is greater than or equal to the user-provided confidence will be included by the algorithm.

For any given confidence threshold, we can view the set of rules thrown out by the algorithm:

<table>
<thead>
<tr>
<th style="text-align:left;">
rules
</th>
<th style="text-align:right;">
support
</th>
<th style="text-align:right;">
confidence
</th>
<th style="text-align:right;">
lift
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
{Lime Sparkling Water} => {Sparkling Water Grapefruit}
</td>
<td style="text-align:right;">
0.0088724
</td>
<td style="text-align:right;">
0.3690476
</td>
<td style="text-align:right;">
10.656631
</td>
</tr>
<tr>
<td style="text-align:left;">
{Bunched Cilantro} => {Limes}
</td>
<td style="text-align:right;">
0.0077275
</td>
<td style="text-align:right;">
0.3461538
</td>
<td style="text-align:right;">
4.616265
</td>
</tr>
<tr>
<td style="text-align:left;">
{Organic Ginger Root} => {Organic Garlic}
</td>
<td style="text-align:right;">
0.0084430
</td>
<td style="text-align:right;">
0.3241758
</td>
<td style="text-align:right;">
5.243844
</td>
</tr>
<tr>
<td style="text-align:left;">
{Organic Blueberries} => {Organic Strawberries}
</td>
<td style="text-align:right;">
0.0130223
</td>
<td style="text-align:right;">
0.3063973
</td>
<td style="text-align:right;">
2.358045
</td>
</tr>
<tr>
<td style="text-align:left;">
{Organic D’Anjou Pears} => {Organic Strawberries}
</td>
<td style="text-align:right;">
0.0078706
</td>
<td style="text-align:right;">
0.3021978
</td>
<td style="text-align:right;">
2.325725
</td>
</tr>
</tbody>
</table>

We can observe that rule 4 states that {Organic Blueberries} => {Organic Strawberries} has a support of 10% and a confidence of 30%. It means Organic Strawberries was found in 30% of all transactions. And 30% of customers who bought Organic Strawberries also bought Organic Blueberries.

If you want stronger rules, you can increase the value of the **confidence** parameter

<br />
<br />

#### Visualizing Association Rules

The network graph below shows associations between selected items. Larger circles imply higher support, while red circles imply higher lift. Graphs only work well with very few rules

<div id="htmlwidget-1" style="width:672px;height:480px;" class="visNetwork html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"nodes":{"id":[1,2,3,4,5,6,7,8,9,10,11,12,13,14],"label":["Bunched Cilantro","Lime Sparkling Water","Limes","Organic Blueberries","Organic D'Anjou Pears","Organic Garlic","Organic Ginger Root","Organic Strawberries","Sparkling Water Grapefruit","rule 1","rule 2","rule 3","rule 4","rule 5"],"group":[1,1,1,1,1,1,1,1,1,2,2,2,2,2],"value":[1,1,1,1,1,1,1,1,1,22.4054054054054,1,14.3783783783784,100,3.67567567567568],"color":["#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#EE1B1B","#EEB7B7","#EEACAC","#EEDBDB","#EEDCDC"],"title":["Bunched Cilantro","Lime Sparkling Water","Limes","Organic Blueberries","Organic D'Anjou Pears","Organic Garlic","Organic Ginger Root","Organic Strawberries","Sparkling Water Grapefruit","<B>[1]<\/B><BR><B>{Lime Sparkling Water}<\/B><BR>&nbsp;&nbsp; => <B>{Sparkling Water Grapefruit}<\/B><BR><BR>support = 0.00887<BR>confidence = 0.369<BR>coverage = 0.024<BR>lift = 10.7<BR>count = 62<BR>order = 2<BR>id = 1","<B>[2]<\/B><BR><B>{Bunched Cilantro}<\/B><BR>&nbsp;&nbsp; => <B>{Limes}<\/B><BR><BR>support = 0.00773<BR>confidence = 0.346<BR>coverage = 0.0223<BR>lift = 4.62<BR>count = 54<BR>order = 2<BR>id = 2","<B>[3]<\/B><BR><B>{Organic Ginger Root}<\/B><BR>&nbsp;&nbsp; => <B>{Organic Garlic}<\/B><BR><BR>support = 0.00844<BR>confidence = 0.324<BR>coverage = 0.026<BR>lift = 5.24<BR>count = 59<BR>order = 2<BR>id = 3","<B>[4]<\/B><BR><B>{Organic Blueberries}<\/B><BR>&nbsp;&nbsp; => <B>{Organic Strawberries}<\/B><BR><BR>support = 0.013<BR>confidence = 0.306<BR>coverage = 0.0425<BR>lift = 2.36<BR>count = 91<BR>order = 2<BR>id = 4","<B>[5]<\/B><BR><B>{Organic D'Anjou Pears}<\/B><BR>&nbsp;&nbsp; => <B>{Organic Strawberries}<\/B><BR><BR>support = 0.00787<BR>confidence = 0.302<BR>coverage = 0.026<BR>lift = 2.33<BR>count = 55<BR>order = 2<BR>id = 5"],"shape":["box","box","box","box","box","box","box","box","box","circle","circle","circle","circle","circle"],"x":[1,0.669469588055588,0.900312437979196,-0.908966878314262,-0.754382902701149,0.0017566807174052,0.120850019689641,-0.987402033229211,-0.0398934133194454,0.281428174748104,0.958262261727609,-0.0165569230723577,-1,-0.85185828672664],"y":[-0.209387586216373,-0.766967850330214,0.473918824243609,0.5897493679313,-0.79543934588583,0.337374427014857,1,-0.119796174355259,-1,-0.810404523886335,0.128753439599453,0.690947817764069,0.247049918066696,-0.466041307791485]},"edges":{"from":[2,1,7,4,5,10,11,12,13,14],"to":[10,11,12,13,14,9,3,6,8,8],"arrows":["to","to","to","to","to","to","to","to","to","to"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot","physics":false},"manipulation":{"enabled":false},"edges":{"smooth":false},"physics":{"stabilization":false},"interaction":{"hover":true,"zoomSpeed":1}},"groups":["1","2"],"width":null,"height":null,"idselection":{"enabled":true,"style":"width: 150px; height: 26px","useLabels":true,"main":"Select by id"},"byselection":{"enabled":false,"style":"width: 150px; height: 26px","multiple":false,"hideColor":"rgba(200,200,200,0.5)","highlight":false},"main":null,"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","igraphlayout":{"type":"square"},"tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);","highlight":{"enabled":true,"hoverNearest":true,"degree":1,"algorithm":"all","hideColor":"rgba(200,200,200,0.5)","labelOnly":true},"collapse":{"enabled":false,"fit":false,"resetHighlight":true,"clusterOptions":null,"keepCoord":true,"labelSuffix":"(cluster)"}},"evals":[],"jsHooks":[]}</script>

<br />
#### Conclusion

You have learned about Association Rule Mining and and its applications in retail.This type of analysis can help marketing executives come up with a more strategic decision in retail environments.

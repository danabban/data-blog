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
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

<script src="{{< blogdown/postref >}}index_files/htmlwidgets/htmlwidgets.js"></script>
<link href="{{< blogdown/postref >}}index_files/vis/vis-network.min.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index_files/vis/vis-network.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/visNetwork-binding/visNetwork.js"></script>

On Amazon’s product page, users are presented with related products, under the heading **“Frequently bought together”** and **Customers who bought this item also bought**.

Knowing what your customers tend to buy together can help with marketing efforts and cause you to optimize your store’s layout for conversion.

There are several algorithmic implementations for the phenomenon described above, one we would be exploring in this example is the apriori algorithm.

In simple language, the algorithm is used to find frequent patterns in a database, in the example we would be looking at, the algorithm would tell us what items customers frequently buy together by generating a set of rules called **Association Rules**.

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
<br />

#### Example Dataset

We would explore data from an online grocery store. The table below shows the first 5 observations with two variables:

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

#### A Summary of How the Algorithm Works

-   Finds frequent itemset in the database.
-   Calculates the support for every item.
-   If support is less than minimum support set by the user, discards the item. Else, inserts it into the list of frequent itemset.
-   Calculates the confidence for each non- empty subset.
-   If confidence is less than minimum confidence set by the user, discard the subset. Else, insert it into the list of strong rules.

<br />
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

For the given confidence threshold, we can view the set of rules thrown out by the algorithm:

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
{Total 2% Lowfat Greek Strained Yogurt With Blueberry} => {Total 2% with Strawberry Lowfat Greek Strained Yogurt}
</td>
<td style="text-align:right;">
0.0054379
</td>
<td style="text-align:right;">
0.5507246
</td>
<td style="text-align:right;">
32.070531
</td>
</tr>
<tr>
<td style="text-align:left;">
{Non Fat Raspberry Yogurt} => {Icelandic Style Skyr Blueberry Non-fat Yogurt}
</td>
<td style="text-align:right;">
0.0052948
</td>
<td style="text-align:right;">
0.5606061
</td>
<td style="text-align:right;">
51.546252
</td>
</tr>
<tr>
<td style="text-align:left;">
{Icelandic Style Skyr Blueberry Non-fat Yogurt} => {Non Fat Raspberry Yogurt}
</td>
<td style="text-align:right;">
0.0052948
</td>
<td style="text-align:right;">
0.4868421
</td>
<td style="text-align:right;">
51.546252
</td>
</tr>
<tr>
<td style="text-align:left;">
{Total 0% Nonfat Greek Yogurt} => {Banana}
</td>
<td style="text-align:right;">
0.0055810
</td>
<td style="text-align:right;">
0.4148936
</td>
<td style="text-align:right;">
1.991261
</td>
</tr>
<tr>
<td style="text-align:left;">
{Bartlett Pears} => {Banana}
</td>
<td style="text-align:right;">
0.0078706
</td>
<td style="text-align:right;">
0.4545455
</td>
<td style="text-align:right;">
2.181568
</td>
</tr>
<tr>
<td style="text-align:left;">
{Sparkling Lemon Water} => {Sparkling Water Grapefruit}
</td>
<td style="text-align:right;">
0.0067258
</td>
<td style="text-align:right;">
0.4017094
</td>
<td style="text-align:right;">
11.599774
</td>
</tr>
<tr>
<td style="text-align:left;">
{Broccoli Crown} => {Banana}
</td>
<td style="text-align:right;">
0.0074413
</td>
<td style="text-align:right;">
0.4031008
</td>
<td style="text-align:right;">
1.934662
</td>
</tr>
<tr>
<td style="text-align:left;">
{Red Vine Tomato} => {Banana}
</td>
<td style="text-align:right;">
0.0103034
</td>
<td style="text-align:right;">
0.4067797
</td>
<td style="text-align:right;">
1.952319
</td>
</tr>
<tr>
<td style="text-align:left;">
{Honeycrisp Apple} => {Banana}
</td>
<td style="text-align:right;">
0.0161706
</td>
<td style="text-align:right;">
0.4248120
</td>
<td style="text-align:right;">
2.038864
</td>
</tr>
<tr>
<td style="text-align:left;">
{Organic Fuji Apple} => {Banana}
</td>
<td style="text-align:right;">
0.0181740
</td>
<td style="text-align:right;">
0.4110032
</td>
<td style="text-align:right;">
1.972590
</td>
</tr>
<tr>
<td style="text-align:left;">
{Organic Avocado,Organic Strawberries} => {Banana}
</td>
<td style="text-align:right;">
0.0061534
</td>
<td style="text-align:right;">
0.4018692
</td>
<td style="text-align:right;">
1.928751
</td>
</tr>
</tbody>
</table>

We can observe that rule 6 states that {beer -> rice} has a support of 50% and a confidence of 67%. This means this rule was found in 50% of all transactions. The confidence that rice (LHS) is purchased given beer (RHS) is purchased (P(rice\|beer)) is 67%. In other words, 67% of the times a customer buys beer, rice is bought as well.

If you want stronger rules, you can increase the value of the **confidence** parameter

Lift: Often, we may have rules with high support and confidence but that are, as yet, of no use. This occurs when the item at the right-hand side of the rule has more probability of being selected alone than with the associated item.This is where lift comes to our rescue. For two products, A and B, lift measures how many times A and B occur together, more often than expected if they were statistically independent.

Rules with lift values greater than one are considered to be more effective.

<br />
<br />

#### Visualizing Association Rules

The network graph below shows associations between selected items. Larger circles imply higher support, while red circles imply higher lift. Graphs only work well with very few rules, why we only use a subset of 10 rules from our data:

Let’s select 10 rules from subRules having the highest confidence.

<div id="htmlwidget-1" style="width:672px;height:480px;" class="visNetwork html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"nodes":{"id":[1,2,3,4,5,6,7,8,9,10,11,12],"label":["Banana","Bartlett Pears","Honeycrisp Apple","Icelandic Style Skyr Blueberry Non-fat Yogurt","Non Fat Raspberry Yogurt","Total 2% Lowfat Greek Strained Yogurt With Blueberry","Total 2% with Strawberry Lowfat Greek Strained Yogurt","rule 1","rule 2","rule 3","rule 4","rule 5"],"group":[1,1,1,1,1,1,1,2,2,2,2,2],"value":[1,1,1,1,1,1,1,1,2.30263157894737,1,24.4473684210526,100],"color":["#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#CBD2FC","#EE1B1B","#EE7E7E","#EE1B1B","#EEDBDB","#EEDCDC"],"title":["Banana","Bartlett Pears","Honeycrisp Apple","Icelandic Style Skyr Blueberry Non-fat Yogurt","Non Fat Raspberry Yogurt","Total 2% Lowfat Greek Strained Yogurt With Blueberry","Total 2% with Strawberry Lowfat Greek Strained Yogurt","<B>[1]<\/B><BR><B>{Non Fat Raspberry Yogurt}<\/B><BR>&nbsp;&nbsp; => <B>{Icelandic Style Skyr Blueberry Non-fat Yogurt}<\/B><BR><BR>support = 0.00529<BR>confidence = 0.561<BR>coverage = 0.00944<BR>lift = 51.5<BR>count = 37<BR>order = 2<BR>id = 1","<B>[2]<\/B><BR><B>{Total 2% Lowfat Greek Strained Yogurt With Blueberry}<\/B><BR>&nbsp;&nbsp; => <B>{Total 2% with Strawberry Lowfat Greek Strained Yogurt}<\/B><BR><BR>support = 0.00544<BR>confidence = 0.551<BR>coverage = 0.00987<BR>lift = 32.1<BR>count = 38<BR>order = 2<BR>id = 2","<B>[3]<\/B><BR><B>{Icelandic Style Skyr Blueberry Non-fat Yogurt}<\/B><BR>&nbsp;&nbsp; => <B>{Non Fat Raspberry Yogurt}<\/B><BR><BR>support = 0.00529<BR>confidence = 0.487<BR>coverage = 0.0109<BR>lift = 51.5<BR>count = 37<BR>order = 2<BR>id = 3","<B>[4]<\/B><BR><B>{Bartlett Pears}<\/B><BR>&nbsp;&nbsp; => <B>{Banana}<\/B><BR><BR>support = 0.00787<BR>confidence = 0.455<BR>coverage = 0.0173<BR>lift = 2.18<BR>count = 55<BR>order = 2<BR>id = 4","<B>[5]<\/B><BR><B>{Honeycrisp Apple}<\/B><BR>&nbsp;&nbsp; => <B>{Banana}<\/B><BR><BR>support = 0.0162<BR>confidence = 0.425<BR>coverage = 0.0381<BR>lift = 2.04<BR>count = 113<BR>order = 2<BR>id = 5"],"shape":["box","box","box","box","box","box","box","circle","circle","circle","circle","circle"],"x":[-0.235963934775789,-1,0.637266405757074,-0.788225314027787,-0.127522622634408,0.751566506215545,1,-0.452266176881012,0.882767744797075,-0.456054869271486,-0.65994270795506,0.215833635356831],"y":[0.984108723854051,0.514136524605082,0.925518394130748,-0.655034768691097,-0.703033295044328,-0.770390939426168,0.100893600951169,-0.356565246621575,-0.335424211767626,-1,0.798087779960343,1]},"edges":{"from":[5,6,4,2,3,8,9,10,11,12],"to":[8,9,10,11,12,4,7,5,1,1],"arrows":["to","to","to","to","to","to","to","to","to","to"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot","physics":false},"manipulation":{"enabled":false},"edges":{"smooth":false},"physics":{"stabilization":false},"interaction":{"hover":true,"zoomSpeed":1}},"groups":["1","2"],"width":null,"height":null,"idselection":{"enabled":true,"style":"width: 150px; height: 26px","useLabels":true,"main":"Select by id"},"byselection":{"enabled":false,"style":"width: 150px; height: 26px","multiple":false,"hideColor":"rgba(200,200,200,0.5)","highlight":false},"main":null,"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","igraphlayout":{"type":"square"},"tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);","highlight":{"enabled":true,"hoverNearest":true,"degree":1,"algorithm":"all","hideColor":"rgba(200,200,200,0.5)","labelOnly":true},"collapse":{"enabled":false,"fit":false,"resetHighlight":true,"clusterOptions":null,"keepCoord":true,"labelSuffix":"(cluster)"}},"evals":[],"jsHooks":[]}</script>

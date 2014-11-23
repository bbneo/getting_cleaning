from a teaching example dataset:

start with this RAW dataset (at the bottom) which is messy on apple and orange production by country and year
after removing some useless lines and reorganizing (adding some column names, etc):

# removing some useless lines

> aodata <- aodata[ which(aodata$country != "Food supply quantity (tonnes) (tonnes)"), ]

# cleaning up the product tons column

> aodata$tonnes <- gsub("\xca","", aodata$tonnes)

> aodata$tonnes <- gsub(", tonnes \\(\\)",'',aodata$tonnes)


> head(aodata)
   country countrynumber            products productnumber    tonnes year
6  Albania             3 Apples and products          2617  57459.00 2009
8  Albania             3 Oranges, Mandarines          2611  40880.00 2009
10 Algeria             4 Apples and products          2617 370008.00 2009
12 Algeria             4 Oranges, Mandarines          2611 762365.00 2009
14  Angola             7 Apples and products          2617   4481.00 2009
16  Angola             7 Oranges, Mandarines          2611    978.00 2009
>


THEN after subsetting the data into a set for "apples" and one for "oranges" and then remerging them together, you get cleanao2:

> apples <- aodata[aodata$productnumber == 2617,c(1,2,5)]
> names(apples)
[1] "country"       "countrynumber" "tonnes"      

> head(apples)
               country countrynumber    tonnes
6              Albania             3  57459.00
10             Algeria             4 370008.00
14              Angola             7   4481.00
18 Antigua and Barbuda             8    722.00
22           Argentina             9 537569.00
26             Armenia             1  45772.00
> names(apples)[3] <- "apples"

> oranges <- aodata[aodata$productnumber == 2611, c(2,5)]
> head(oranges)
   countrynumber    tonnes
8              3  40880.00
12             4 762365.00
16             7    978.00
20             8   3521.00
24             9 890101.00
28             1  11301.00

> names(oranges)[2] <- "oranges"
> head(oranges)
   countrynumber   oranges
8              3  40880.00
12             4 762365.00
16             7    978.00
20             8   3521.00
24             9 890101.00
28             1  11301.00

> cleanao2 <- merge(apples,oranges, by="countrynumber", all=T)

> dim(cleanao2)
[1] 175   4
> head(cleanao2,20)
   countrynumber                               country     apples    oranges
1              1                               Armenia   45772.00   11301.00
2             10                             Australia  614376.00  376653.00
3            100                                 India 1698181.00 4678265.00
4            101                             Indonesia  162865.00 2161570.00
5            102            Iran (Islamic Republic of) 1747792.00 2151983.00
6            104                               Ireland   81822.00  400143.00
7            105                                Israel  135919.00  159052.00
8            106                                 Italy 1171850.00 2845215.00
9            107                      C\x99te d Ivoire    7051.00   32749.00
10           108                            Kazakhstan  359245.00   61858.00
11           109                               Jamaica    4617.00  111536.00
12            11                               Austria  356264.00   86030.00
13           110                                 Japan 1993726.00 1308999.00
14           112                                Jordan   55980.00   71520.00
15           113                            Kyrgyzstan  117436.00    9126.00
16           114                                 Kenya    6890.00   33604.00
17           115                              Cambodia    2265.00   65304.00
18           116 Democratic People s Republic of Korea  655103.00       2.00
19           117                     Republic of Korea  376240.00 1009303.00
20           118                                Kuwait   17927.00   67534.00


===========================================================

RAW data:

> head(aoraw,20)
                                       V1 V2
1                            FAOSTAT 2013  
2                           Elements \xca  
3  Food supply quantity (tonnes) (tonnes)  
4  Food supply quantity (tonnes) (tonnes)  
5  Food supply quantity (tonnes) (tonnes)  
6                                 Albania  3
7  Food supply quantity (tonnes) (tonnes)  
8                                 Albania  3
9  Food supply quantity (tonnes) (tonnes)  
10                                Algeria  4
11 Food supply quantity (tonnes) (tonnes)  
12                                Algeria  4
13 Food supply quantity (tonnes) (tonnes)  
14                                 Angola  7
15 Food supply quantity (tonnes) (tonnes)  
16                                 Angola  7
17 Food supply quantity (tonnes) (tonnes)  
18                    Antigua and Barbuda  8
19 Food supply quantity (tonnes) (tonnes)  
20                    Antigua and Barbuda  8
                                       V3   V4                       V5   V6
1                                           NA                            NA
2                              Areas \xca   NA               Items \xca 2009
3                                           NA                            NA
4  Food supply quantity (tonnes) (tonnes)   NA                            NA
5                                           NA                            NA
6                     Apples and products 2617  57\xca459.00, tonnes ()   NA
7                                           NA                            NA
8                     Oranges, Mandarines 2611  40\xca880.00, tonnes ()   NA
9                                           NA                            NA
10                    Apples and products 2617 370\xca008.00, tonnes ()   NA
11                                          NA                            NA
12                    Oranges, Mandarines 2611 762\xca365.00, tonnes ()   NA
13                                          NA                            NA
14                    Apples and products 2617   4\xca481.00, tonnes ()   NA
15                                          NA                            NA
16                    Oranges, Mandarines 2611        978.00, tonnes ()   NA
17                                          NA                            NA
18                    Apples and products 2617        722.00, tonnes ()   NA
19                                          NA                            NA
20                    Oranges, Mandarines 2611   3\xca521.00, tonnes ()   NA


> library(reshape2)
> cleanao3 <- dcast(aodata[,c(1:3,5)], formula = country + countrynumber ~ products, value.var="tonnes")
> cleanao2[!(complete.cases(cleanao2)),]
    countrynumber country  apples  oranges
86            207    <NA>    <NA> 11432.00
122            28 Myanmar 3134.00     <NA>
> cleanao3[!(complete.cases(cleanao3)),]
     country countrynumber Apples and products Oranges, Mandarines
107  Myanmar            28             3134.00                <NA>
148 Suriname           207                <NA>            11432.00
>

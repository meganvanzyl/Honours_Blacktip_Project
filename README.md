# README


Add Binder Badge here

## Background Information

![“Image of Blacktip Shark (*Carcharhinus
limbatus*)”](images/Carcharhinus%20limbatus.jpg)

This study investigates the migration of blacktip sharks (*Carcharhinus
limbatus*) along the east coast of southern Africa to better understand
their foraging ecology. Sharks were captured and fitted with surgically
implanted acoustic transmitters in the coelomic cavity. A network of
fixed acoustic receivers detects tagged individuals when they move
within detection range, generating time-stamped records of presence
along the coastline. Data were collected between 2020 and 2025 and will
be analysed in R to characterise movement patterns and evaluate
potential drivers of seasonal and spatial migration.

## Raw Data

The raw data files can be found
[here](https://github.com/meganvanzyl/Honours_Blacktip_Project/tree/main/Data/Raw_Data).

### There are 3 raw data files:

<table style="width:99%;">
<colgroup>
<col style="width: 40%" />
<col style="width: 36%" />
<col style="width: 22%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><h4
id="the-blacktip-metadata-of-individual-sharks">The Blacktip Metadata of
individual sharks</h4></th>
<th style="text-align: center;"><h4 id="the-receiver-metadata">The
Receiver Metadata</h4></th>
<th style="text-align: center;"><h4 id="the-blacktip-detections">The
Blacktip Detections</h4></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;"><ul>
<li><p>Tag IDs</p></li>
<li><p>Gender</p></li>
<li><p>Measurements (length from nose to tip of the upper caudal
lobe)</p></li>
<li><p>Release date (YYYY/MM/DD) and location (longitude and
latitude)</p></li>
<li><p>Catch Area</p></li>
</ul></td>
<td style="text-align: center;"><ul>
<li><p>Station name and location (latitude and longitude)</p></li>
<li><p>Project Name: ORI</p></li>
<li><p>Deployment and recovery date (YYYY/MM/DD) and time (hms)</p></li>
</ul></td>
<td style="text-align: center;"><ul>
<li><p>Date (YYYY/DD/MM) and time (hms)</p></li>
<li><p>Receiver and Transmitter ID</p></li>
<li><p>Location (latitude and longtitde)</p></li>
</ul></td>
</tr>
</tbody>
</table>

## Clean Data

### Blacktip Metadata

The R Script can be found here.

When you click the **Render** button a document will be generated that
includes both content and the output of embedded code. You can embed
code like this:

``` r
1 + 1
```

    [1] 2

You can add options to executable code like this

    [1] 4

The `echo: false` option disables the printing of code (only output is
displayed).

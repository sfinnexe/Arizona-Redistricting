# Arizona Congressional District Compactness Scores: Overview
*Project from GIS for Electoral Redistricting Analysis with Professor Lee Hachadoorian*  
- In this project I analyzed the change in compactness scores of Arizona's congressional districts over time based on different measures of compactness. 
- I compared the Polsby-Popper and Reock compactness scores from the 1970s until 2010. 
- Polsby-Popper scores have generally trended down while Reock scores have generally trended upward. 
- The minimum and maximum Polsby-Popper scores and Reock scores have grown further apart as Arizona has gained congressional districts. 
- Arizona's 2010 congressional districts are considered slightly more compact when you use the Reock score than when you use the Polsby-Popper score. 

## Definitions
1. **Polsby-Popper:** the ratio of the area of a district to the area of a circle whos circumference is equal to the perimeter of the district. (To visualize what this means, it is like comparing a shriveled and defalted balloon to the same kind of balloon that is filled with air.)
2. **Reock:** the ratio of the area of the district to the area of a minimum bounding circle, aka the smallest circle that fully encloses the district.  

## Code and Resources used
**R Version:** 4.0.5  
**R Packages:** tidyverse, sf, tmap  
**Sources:**  
- https://github.com/leehach/compactr for calculating Polsby–Popper and Reock compactness scores. 
- https://cdmaps.polisci.ucla.edu/ for congressional district shapefiles. 

## Visualizations
*For both Polsby-Popper and Reock, scores closer to 1 indicate a more compact district.*

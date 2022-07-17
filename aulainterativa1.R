install.packages('dplyr')
library(dplyr)
install.packages('GGally')
library(GGally)

options(scipen = 666)

#Monta o dataset
dados <- data.frame(price = c(13495, 16500, 16500, 13950, 17450, 15250, 
                              17710, 18920, 23875, 16430, 16925, 20970, 21105, 24565, 30760, 
                              41315, 36880, 5151, 6295, 6575, 5572, 6377, 7957, 6229, 6692, 
                              7609, 8558, 8921, 12964, 6479, 6855, 5399, 6529, 7129, 7295, 
                              7295, 7895, 9095, 8845, 10295, 12945, 10345, 6785, 11048, 32250, 
                              35550, 36000, 5195, 6095, 6795, 6695, 7395, 10945, 11845, 13645, 
                              15645, 8845, 8495, 10595, 10245, 10795, 11245, 18280, 18344, 
                              25552, 28248, 28176, 31600, 34184, 35056, 40960, 45400, 16503, 
                              5389, 6189, 6669, 7689, 9959, 8499, 12629, 14869, 14489, 6989, 
                              8189, 9279, 9279, 5499, 7099, 6649, 6849, 7349, 7299, 7799, 7499, 
                              7999, 8249, 8949, 9549, 13499, 14399, 13499, 17199, 19699, 18399, 
                              11900, 13200, 12440, 13860, 15580, 16900, 16695, 17075, 16630, 
                              17950, 18150, 5572, 7957, 6229, 6692, 7609, 8921, 12764, 22018, 
                              32528, 34028, 37028, 9295, 9895, 11850, 12170, 15040, 15510, 
                              18150, 18620, 5118, 7053, 7603, 7126, 7775, 9960, 9233, 11259, 
                              7463, 10198, 8013, 11694, 5348, 6338, 6488, 6918, 7898, 8778, 
                              6938, 7198, 7898, 7788, 7738, 8358, 9258, 8058, 8238, 9298, 9538, 
                              8449, 9639, 9989, 11199, 11549, 17669, 8948, 10698, 9988, 10898, 
                              11248, 16558, 15998, 15690, 15750, 7775, 7975, 7995, 8195, 8495, 
                              9495, 9995, 11595, 9980, 13295, 13845, 12290, 12940, 13415, 15985, 
                              16515, 18420, 18950, 16845, 19045, 21485, 22470, 22625), 
                    
                    length = c(168.8, 168.8, 171.2, 176.6, 176.6, 177.3, 192.7, 192.7, 192.7, 176.8,
                                176.8, 176.8, 176.8, 189, 189, 193.8, 197, 141.1, 155.9, 158.8, 
                                157.3, 157.3, 157.3, 157.3, 157.3, 157.3, 157.3, 174.6, 173.2, 
                                144.6, 144.6, 150, 150, 150, 163.4, 157.1, 167.5, 167.5, 175.4, 
                                175.4, 175.4, 169.1, 170.7, 172.6, 199.6, 199.6, 191.7, 159.1, 
                                159.1, 159.1, 166.8, 166.8, 169, 169, 169, 169, 177.8, 177.8, 
                                177.8, 177.8, 177.8, 177.8, 175, 175, 190.9, 190.9, 187.5, 202.6, 
                                202.6, 180.3, 208.1, 199.2, 178.4, 157.3, 157.3, 157.3, 157.3, 
                                173, 173, 173.2, 173.2, 173.2, 172.4, 172.4, 172.4, 172.4, 165.3, 
                                165.3, 165.3, 165.3, 170.2, 165.3, 165.6, 165.3, 170.2, 162.4, 
                                173.4, 173.4, 181.7, 184.6, 184.6, 170.7, 170.7, 178.5, 186.7, 
                                186.7, 198.9, 198.9, 186.7, 186.7, 198.9, 198.9, 186.7, 186.7, 
                                186.7, 157.3, 157.3, 157.3, 167.3, 167.3, 174.6, 173.2, 168.9, 
                                168.9, 168.9, 168.9, 181.5, 176.8, 186.6, 186.6, 186.6, 186.6, 
                                186.6, 186.6, 156.9, 157.9, 157.3, 172, 172, 172, 172, 172, 173.5, 
                                173.5, 173.6, 173.6, 158.7, 158.7, 158.7, 169.7, 169.7, 169.7, 
                                166.3, 166.3, 166.3, 166.3, 166.3, 166.3, 166.3, 168.7, 168.7, 
                                168.7, 168.7, 176.2, 176.2, 176.2, 176.2, 176.2, 176.2, 175.6, 
                                175.6, 175.6, 175.6, 175.6, 183.5, 183.5, 187.8, 187.8, 171.7, 
                                171.7, 171.7, 171.7, 171.7, 171.7, 171.7, 159.3, 165.7, 180.2, 
                                180.2, 183.1, 188.8, 188.8, 188.8, 188.8, 188.8, 188.8, 188.8, 
                                188.8, 188.8, 188.8, 188.8), 
                    
                                width = c(64.1, 64.1, 65.5, 66.2, 
                                66.4, 66.3, 71.4, 71.4, 71.4, 64.8, 64.8, 64.8, 64.8, 66.9, 66.9, 
                                67.9, 70.9, 60.3, 63.6, 63.6, 63.8, 63.8, 63.8, 63.8, 63.8, 63.8, 
                                63.8, 64.6, 66.3, 63.9, 63.9, 64, 64, 64, 64, 63.9, 65.2, 65.2, 
                                65.2, 62.5, 65.2, 66, 61.8, 65.2, 69.6, 69.6, 70.6, 64.2, 64.2, 
                                64.2, 64.2, 64.2, 65.7, 65.7, 65.7, 65.7, 66.5, 66.5, 66.5, 66.5, 
                                66.5, 66.5, 66.1, 66.1, 70.3, 70.3, 70.3, 71.7, 71.7, 70.5, 71.7, 
                                72, 68, 64.4, 64.4, 64.4, 63.8, 65.4, 65.4, 66.3, 66.3, 66.3, 
                                65.4, 65.4, 65.4, 65.4, 63.8, 63.8, 63.8, 63.8, 63.8, 63.8, 63.8, 
                                63.8, 63.8, 63.8, 65.2, 65.2, 66.5, 66.5, 66.5, 67.9, 67.9, 67.9, 
                                68.4, 68.4, 68.4, 68.4, 68.4, 68.4, 68.4, 68.4, 68.4, 68.4, 68.3, 
                                63.8, 63.8, 63.8, 63.8, 63.8, 64.6, 66.3, 68.3, 65, 65, 65, 66.5, 
                                66.6, 66.5, 66.5, 66.5, 66.5, 66.5, 66.5, 63.4, 63.6, 63.8, 65.4, 
                                65.4, 65.4, 65.4, 65.4, 65.4, 65.4, 65.4, 65.4, 63.6, 63.6, 63.6, 
                                63.6, 63.6, 63.6, 64.4, 64.4, 64.4, 64.4, 64.4, 64.4, 64.4, 64, 
                                64, 64, 64, 65.6, 65.6, 65.6, 65.6, 65.6, 65.6, 66.5, 66.5, 66.5, 
                                66.5, 66.5, 67.7, 67.7, 66.5, 66.5, 65.5, 65.5, 65.5, 65.5, 65.5, 
                                65.5, 65.5, 64.2, 64, 66.9, 66.9, 66.9, 67.2, 67.2, 67.2, 67.2, 
                                67.2, 67.2, 68.9, 68.8, 68.9, 68.9, 68.9), 
                                
                                height = c(48.8, 48.8,52.4, 54.3, 54.3, 53.1, 55.7, 55.7, 55.9, 54.3, 
                                54.3, 54.3, 54.3, 55.7, 55.7, 53.7, 56.3, 53.2, 52, 52, 50.8, 50.8, 50.8, 50.6, 
                                50.6, 50.6, 50.6, 59.8, 50.2, 50.8, 50.8, 52.6, 52.6, 52.6, 54.5, 
                                58.3, 53.3, 53.3, 54.1, 54.1, 54.1, 51, 53.5, 51.4, 52.8, 52.8, 
                                47.8, 54.1, 54.1, 54.1, 54.1, 54.1, 49.6, 49.6, 49.6, 49.6, 53.7, 
                                55.5, 53.7, 55.5, 55.5, 55.5, 54.4, 54.4, 56.5, 58.7, 54.9, 56.3, 
                                56.5, 50.8, 56.7, 55.4, 54.8, 50.8, 50.8, 50.8, 50.8, 49.4, 49.4, 
                                50.2, 50.2, 50.2, 51.6, 51.6, 51.6, 51.6, 54.5, 54.5, 54.5, 54.5, 
                                53.5, 54.5, 53.3, 54.5, 53.5, 53.3, 54.7, 54.7, 55.1, 56.1, 55.1, 
                                49.7, 49.7, 49.7, 56.7, 56.7, 58.7, 58.7, 56.7, 56.7, 56.7, 58.7, 
                                56.7, 56.7, 56, 50.8, 50.8, 50.6, 50.8, 50.8, 59.8, 50.2, 50.2, 
                                51.6, 51.6, 51.6, 55.2, 50.5, 56.1, 56.1, 56.1, 56.1, 56.1, 56.1, 
                                53.7, 53.7, 55.7, 52.5, 52.5, 52.5, 54.3, 54.3, 53, 53, 54.9, 
                                54.9, 54.5, 54.5, 54.5, 59.1, 59.1, 59.1, 53, 52.8, 53, 52.8, 
                                53, 52.8, 52.8, 52.6, 52.6, 52.6, 52.6, 52, 52, 52, 52, 52, 53, 
                                54.9, 54.9, 53.9, 54.9, 53.9, 52, 52, 54.1, 54.1, 55.7, 55.7, 
                                55.7, 55.7, 55.7, 55.7, 55.7, 55.6, 51.4, 55.1, 55.1, 55.1, 56.2, 
                                57.5, 56.2, 57.5, 56.2, 57.5, 55.5, 55.5, 55.5, 55.5, 55.5), 
                                
                                `curb-weight` = c(2548, 2548, 2823, 2337, 2824, 2507, 2844, 
                                2954, 3086, 2395, 2395, 2710, 2765, 3055, 3230, 3380, 3505, 
                                1488, 1874, 1909, 1876, 1876, 2128, 1967, 1989, 1989, 2191, 
                                2535, 2811, 1713, 1819, 1837, 1940, 1956, 2010, 2024, 2236, 
                                2289, 2304, 2372, 2465, 2293, 2337, 2734, 4066, 4066, 3950, 
                                1890, 1900, 1905, 1945, 1950, 2380, 2380, 2385, 2500, 2385, 
                                2410, 2385, 2410, 2443, 2425, 2670, 2700, 3515, 3750, 3495, 
                                3770, 3740, 3685, 3900, 3715, 2910, 1918, 1944, 2004, 2145, 
                                2370, 2328, 2833, 2921, 2926, 2365, 2405, 2403, 2403, 1889, 
                                2017, 1918, 1938, 2024, 1951, 2028, 1971, 2037, 2008, 2324, 
                                2302, 3095, 3296, 3060, 3071, 3139, 3139, 3020, 3197, 3230, 
                                3430, 3075, 3252, 3285, 3485, 3075, 3252, 3130, 1918, 2128, 
                                1967, 1989, 2191, 2535, 2818, 2778, 2756, 2756, 2800, 2579, 
                                2460, 2658, 2695, 2707, 2758, 2808, 2847, 2050, 2120, 2240, 
                                2145, 2190, 2340, 2385, 2510, 2290, 2455, 2420, 2650, 1985, 
                                2040, 2015, 2280, 2290, 3110, 2081, 2109, 2275, 2275, 2094, 
                                2122, 2140, 2169, 2204, 2265, 2300, 2540, 2536, 2551, 2679, 
                                2714, 2975, 2326, 2480, 2414, 2414, 2458, 2976, 3016, 3131, 
                                3151, 2261, 2209, 2264, 2212, 2275, 2319, 2300, 2254, 2221, 
                                2661, 2579, 2563, 2912, 3034, 2935, 3042, 3045, 3157, 2952, 
                                3049, 3012, 3217, 3062), 
                                
                                `engine-size` = c(130, 130, 152, 
                                109, 136, 136, 136, 136, 131, 108, 108, 164, 164, 164, 209, 
                                209, 209, 61, 90, 90, 90, 90, 98, 90, 90, 90, 98, 122, 156, 
                                92, 92, 79, 92, 92, 92, 92, 110, 110, 110, 110, 110, 110, 
                                111, 119, 258, 258, 326, 91, 91, 91, 91, 91, 70, 70, 70, 
                                80, 122, 122, 122, 122, 122, 122, 140, 134, 183, 183, 183, 
                                183, 234, 234, 308, 304, 140, 92, 92, 92, 98, 110, 122, 156, 
                                156, 156, 122, 122, 110, 110, 97, 103, 97, 97, 97, 97, 97, 
                                97, 97, 97, 120, 120, 181, 181, 181, 181, 181, 181, 120, 
                                152, 120, 152, 120, 152, 120, 152, 120, 152, 134, 90, 98, 
                                90, 90, 98, 122, 156, 151, 194, 194, 194, 132, 132, 121, 
                                121, 121, 121, 121, 121, 97, 108, 108, 108, 108, 108, 108, 
                                108, 108, 108, 108, 108, 92, 92, 92, 92, 92, 92, 98, 98, 
                                110, 110, 98, 98, 98, 98, 98, 98, 98, 146, 146, 146, 146, 
                                146, 146, 122, 110, 122, 122, 122, 171, 171, 171, 161, 97, 
                                109, 97, 109, 109, 97, 109, 109, 109, 136, 97, 109, 141, 
                                141, 141, 141, 130, 130, 141, 141, 173, 145, 141), 
                    
                                `city-mpg` = c(21, 21, 19, 24, 18, 19, 19, 19, 17, 23, 23, 21, 21, 20, 16, 16, 
                                15, 47, 38, 38, 37, 31, 24, 31, 31, 31, 24, 24, 19, 49, 31, 
                                38, 30, 30, 30, 30, 27, 27, 27, 27, 24, 25, 24, 24, 15, 15, 
                                13, 30, 31, 31, 31, 31, 17, 17, 17, 16, 26, 26, 26, 26, 36, 
                                26, 19, 31, 22, 22, 22, 22, 16, 16, 14, 14, 19, 37, 31, 31, 
                                24, 23, 25, 19, 19, 19, 25, 25, 23, 23, 31, 45, 31, 31, 31, 
                                31, 31, 31, 31, 31, 27, 27, 17, 17, 19, 19, 17, 19, 19, 28, 
                                19, 25, 19, 28, 19, 25, 19, 28, 18, 37, 24, 31, 31, 31, 24, 
                                19, 19, 17, 17, 17, 23, 23, 21, 21, 21, 21, 19, 19, 31, 26, 
                                26, 32, 28, 26, 24, 24, 28, 25, 23, 23, 35, 31, 31, 31, 27, 
                                27, 30, 30, 34, 38, 38, 28, 28, 29, 29, 26, 26, 24, 24, 24, 
                                24, 24, 24, 29, 30, 27, 27, 27, 20, 19, 20, 19, 37, 27, 37, 
                                27, 27, 37, 26, 24, 24, 19, 33, 25, 23, 23, 24, 24, 17, 17, 23, 19, 18, 26, 19),
                                
                                `highway-mpg` = c(27, 27, 26, 30, 22, 25, 25, 25, 20, 29, 29, 28, 28, 25, 22, 22, 20, 53, 43, 43, 
                                41, 38, 30, 38, 38, 38, 30, 30, 24, 54, 38, 42, 34, 34, 34, 
                                34, 33, 33, 33, 33, 28, 31, 29, 29, 19, 19, 17, 31, 38, 38, 
                                38, 38, 23, 23, 23, 23, 32, 32, 32, 32, 42, 32, 27, 39, 25, 
                                25, 25, 25, 18, 18, 16, 16, 24, 41, 38, 38, 30, 30, 32, 24, 
                                24, 24, 32, 32, 30, 30, 37, 50, 37, 37, 37, 37, 37, 37, 37, 
                                37, 34, 34, 22, 22, 25, 25, 23, 25, 24, 33, 24, 25, 24, 33, 
                                24, 25, 24, 33, 24, 41, 30, 38, 38, 38, 30, 24, 27, 25, 25, 
                                25, 31, 31, 28, 28, 28, 28, 26, 26, 36, 31, 31, 37, 33, 32, 
                                25, 29, 32, 31, 29, 23, 39, 38, 38, 37, 32, 32, 37, 37, 36, 
                                47, 47, 34, 34, 34, 34, 29, 29, 30, 30, 30, 30, 30, 30, 34, 
                                33, 32, 32, 32, 24, 24, 24, 24, 46, 34, 46, 34, 34, 42, 32, 
                                29, 29, 24, 38, 31, 28, 28, 28, 28, 22, 22, 28, 25, 23, 27, 
                                25),
                    
                                `fuel-type` = c("gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "diesel", "gas", "gas", "diesel", "diesel", "diesel", "diesel", 
                                 "diesel", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "diesel", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "diesel", "gas", "diesel", "gas", 
                                 "diesel", "gas", "diesel", "gas", "diesel", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "diesel", "diesel", "gas", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "diesel", "gas", "gas", "gas", "gas", "gas", "gas", 
                                 "gas", "diesel", "gas", "diesel", "gas", "gas", "diesel", 
                                 "gas", "gas", "gas", "gas", "diesel", "gas", "gas", "gas", 
                                 "gas", "gas", "gas", "gas", "gas", "gas", "gas", "diesel", 
                                 "gas"),
                    
                                  aspiration = c("std", "std", "std", "std", "std", 
                                  "std", "std", "std", "turbo", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "turbo", "std", "std", "std", "turbo", "std", "turbo", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "turbo", 
                                  "turbo", "turbo", "turbo", "std", "std", "std", "std", "turbo", 
                                  "std", "std", "std", "turbo", "turbo", "std", "turbo", "turbo", 
                                  "turbo", "std", "std", "turbo", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "turbo", "std", "std", "turbo", 
                                  "std", "turbo", "std", "turbo", "std", "turbo", "std", "turbo", 
                                  "turbo", "std", "turbo", "std", "std", "std", "std", "turbo", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "turbo", "turbo", "std", "std", "std", "std", "std", 
                                  "std", "std", "turbo", "std", "std", "std", "turbo", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "std", "std", "std", "std", "turbo", "std", "std", 
                                  "std", "std", "std", "std", "std", "std", "std", "std", "std", 
                                  "std", "turbo", "std", "std", "std", "std", "turbo", "std", 
                                  "std", "std", "std", "std", "turbo", "turbo", "std", "turbo", 
                                  "std", "turbo", "turbo"), `num-of-doors` = c("two", "two", 
"two", "four", "four", "two", "four", "four", "four", "two", 
"four", "two", "four", "four", "four", "two", "four", "two", 
"two", "four", "two", "two", "two", "four", "four", "four", 
"?", "four", "two", "two", "two", "two", "two", "two", "four", 
"four", "two", "two", "four", "four", "four", "two", "four", 
"two", "four", "four", "two", "two", "two", "two", "four", 
"four", "two", "two", "two", "two", "two", "four", "two", 
"four", "?", "four", "four", "four", "four", "four", "two", 
"four", "four", "two", "four", "two", "two", "two", "two", 
"two", "two", "two", "two", "two", "two", "two", "four", 
"four", "four", "four", "two", "two", "two", "four", "four", 
"two", "two", "four", "four", "two", "four", "four", "four", 
"four", "four", "two", "two", "two", "four", "four", "four", 
"four", "four", "four", "four", "four", "four", "four", "four", 
"two", "two", "four", "four", "four", "four", "two", "two", 
"two", "two", "two", "four", "two", "two", "four", "two", 
"four", "two", "four", "two", "two", "two", "four", "four", 
"four", "four", "four", "four", "four", "four", "four", "two", 
"two", "four", "four", "four", "four", "four", "four", "four", 
"four", "four", "four", "four", "two", "two", "two", "two", 
"two", "two", "two", "two", "two", "two", "four", "four", 
"four", "four", "four", "two", "two", "four", "four", "two", 
"two", "four", "four", "four", "four", "four", "two", "two", 
"four", "four", "four", "four", "four", "four", "four", "four", 
"four", "four", "four", "four", "four", "four"), `body-style` = c("convertible", 
                           "convertible", "hatchback", "sedan", "sedan", "sedan", "sedan", 
                           "wagon", "sedan", "sedan", "sedan", "sedan", "sedan", "sedan", 
                           "sedan", "sedan", "sedan", "hatchback", "hatchback", "sedan", 
                           "hatchback", "hatchback", "hatchback", "hatchback", "sedan", 
                           "sedan", "sedan", "wagon", "hatchback", "hatchback", "hatchback", 
                           "hatchback", "hatchback", "hatchback", "sedan", "wagon", 
                           "hatchback", "hatchback", "sedan", "sedan", "sedan", "sedan", 
                           "sedan", "hatchback", "sedan", "sedan", "sedan", "hatchback", 
                           "hatchback", "hatchback", "sedan", "sedan", "hatchback", 
                           "hatchback", "hatchback", "hatchback", "hatchback", "sedan", 
                           "hatchback", "sedan", "sedan", "hatchback", "sedan", "sedan", 
                           "sedan", "wagon", "hardtop", "sedan", "sedan", "convertible", 
                           "sedan", "hardtop", "hatchback", "hatchback", "hatchback", 
                           "hatchback", "hatchback", "hatchback", "hatchback", "hatchback", 
                           "hatchback", "hatchback", "sedan", "sedan", "sedan", "sedan", 
                           "sedan", "sedan", "sedan", "sedan", "wagon", "sedan", "hatchback", 
                           "sedan", "wagon", "hardtop", "hatchback", "sedan", "sedan", 
                           "wagon", "sedan", "hatchback", "hatchback", "hatchback", 
                           "sedan", "sedan", "wagon", "wagon", "sedan", "sedan", "wagon", 
                           "wagon", "sedan", "sedan", "sedan", "hatchback", "hatchback", 
                           "hatchback", "sedan", "sedan", "wagon", "hatchback", "hatchback", 
                           "hardtop", "hardtop", "convertible", "wagon", "hatchback", 
                           "hatchback", "sedan", "hatchback", "sedan", "hatchback", 
                           "sedan", "hatchback", "hatchback", "hatchback", "sedan", 
                           "sedan", "sedan", "sedan", "sedan", "wagon", "wagon", "wagon", 
                           "wagon", "hatchback", "hatchback", "hatchback", "wagon", 
                           "wagon", "wagon", "sedan", "hatchback", "sedan", "hatchback", 
                           "sedan", "hatchback", "sedan", "sedan", "hatchback", "sedan", 
                           "hatchback", "hardtop", "hardtop", "hatchback", "hardtop", 
                           "hatchback", "convertible", "sedan", "sedan", "hatchback", 
                           "sedan", "hatchback", "hatchback", "hatchback", "sedan", 
                           "wagon", "sedan", "sedan", "sedan", "sedan", "sedan", "sedan", 
                           "sedan", "convertible", "hatchback", "sedan", "sedan", "wagon", 
                           "sedan", "wagon", "sedan", "wagon", "sedan", "wagon", "sedan", 
                           "sedan", "sedan", "sedan", "sedan"), 

                            `drive-wheels` = c("rwd", 
                           "rwd", "rwd", "fwd", "4wd", "fwd", "fwd", "fwd", "fwd", "rwd", 
                           "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "rwd", "rwd", "rwd", "rwd", 
                           "rwd", "fwd", "fwd", "fwd", "fwd", "fwd", "rwd", "rwd", "rwd", 
                           "rwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "rwd", "rwd", 
                           "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", 
                           "fwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", 
                           "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "fwd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "rwd", "rwd", "rwd", "rwd", "rwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", 
                           "4wd", "fwd", "fwd", "fwd", "4wd", "4wd", "fwd", "fwd", "4wd", 
                           "4wd", "fwd", "fwd", "fwd", "fwd", "4wd", "4wd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "rwd", "rwd", "rwd", "rwd", 
                           "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "fwd", "fwd", "fwd", 
                           "fwd", "fwd", "rwd", "rwd", "rwd", "rwd", "fwd", "fwd", "fwd", 
                           "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", "fwd", 
                           "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", "rwd", 
                           "rwd", "rwd"), `engine-location` = c("front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "rear", "rear", "rear", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front", "front", "front", "front", "front", "front", 
                                                                                "front", "front"), `num-of-cylinders` = c("four", "four", 
                                                                                                                          "six", "four", "five", "five", "five", "five", "five", "four", 
                                                                                                                          "four", "six", "six", "six", "six", "six", "six", "three", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "six", "six", "twelve", "four", "four", "four", 
                                                                                                                          "four", "four", "two", "two", "two", "two", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "five", "five", 
                                                                                                                          "five", "five", "eight", "eight", "eight", "eight", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "six", "six", "six", "six", "six", "six", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "six", "six", "six", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                          "four", "four", "four", "four", "four", "six", "six", "six", 
                                                                                                                          "six", "four", "four", "four", "four", "four", "four", "four", 
                                                                                                                                                                                                "four", "four", "five", "four", "four", "four", "four", "four", 
                                                                                                                                                                                                                                                                                                "four", "four", "four", "four", "four", "six", "six", "four")) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "four", "four", "five", "four", "four", "four", "four", "four", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                    "four", "four", "four", "four", "four", "six", "six", "four"))

#Renomeia as colunas para portugues
names(dados) <- c('Preco',
                  'Comprimento',
                  'Largura',
                  'Altura',
                  'Peso',
                  'Tamanho_Motor',
                  'Milhas_por_Litro_na_Cidade',
                  'Milhas_por_Litro_na_Estrada',
                  'Tipo_Combustivel',
                  'Possui_Turbo',
                  'Numero_de_Portas',
                  'Estilo_do_Corpo',
                  'Tracao',
                  'Localizacao_do_Motor',
                  'Numero_de_Cilindros')

#Visualiza tipo de cada variavel
str(dados)

#Converte as variaveis categoricas para factor
dados$Tipo_Combustivel <- as.factor(dados$Tipo_Combustivel)
dados$Possui_Turbo <- as.factor(dados$Possui_Turbo)
dados$Numero_de_Portas <- as.factor(dados$Numero_de_Portas)
dados$Estilo_do_Corpo <- as.factor(dados$Estilo_do_Corpo)
dados$Tracao <- as.factor(dados$Tracao)
dados$Localizacao_do_Motor <- as.factor(dados$Localizacao_do_Motor)
dados$Numero_de_Cilindros <- as.factor(dados$Numero_de_Cilindros)

#Com a biblioteca dplyr, e possivel converter todas variaveis categoricas
#para factor de uma vez

dados <- dados %>% mutate_if(is.character,as.factor)                 

str(dados)

#Visualiza resumo descritivo das variaveis
summary(dados)

#Explora a variavel resposta: Preco
hist(dados$Preco)

boxplot(dados$Preco)

summary(dados$Preco)

#Suspeita-se que a variavel Tipo_Combustivel possui associacao com o fato
#do veiculo Possuir_Turbo. Investigue a relação entre essas

tabela_contigencia <- table(dados$Tipo_Combustivel, dados$Possui_Turbo)
tabela_contigencia

plot(tabela_contigencia)

chisq.test(tabela_contigencia)

#Explore a variável Comprimento
hist(dados$Comprimento)

#Explorando a relacao entre Comprimento e Possui_Turbo
boxplot(dados$Comprimento ~ dados$Possui_Turbo)

t.test(dados$Comprimento ~ dados$Possui_Turbo)

#Explore a relação entre as variáveis Preço e Peso
plot(y = dados$Preco,
     x = dados$Peso,
     pch = 16)


#Coeficiente de correlacao entre Preco e Peso
cor(dados$Preco, dados$Peso)


#Regressao linear simples entre Peso e Preco
fit <- lm(Preco ~ Peso, data = dados)
summary(fit)


#Regressao linear multipla
fit <- lm(Preco ~ ., data = dados)
summary(fit)

#Diagnostico de residuos
hist(fit$residuals)
shapiro.test(fit$residuals)

#stepwise
fit <- step(fit)
summary(fit)

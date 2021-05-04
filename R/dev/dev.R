# library(opentimsr)
# library(data.table)
# library(microbenchmark)
library(devtools)

rm(list=c('all_columns', ".__T__[:base"))
document()
document()
build()
install()
load_all()

library(timsr)
path = "/home/matteo/Projects/bruker/BrukerMIDIA/MIDIA_CE10_precursor/20190912_HeLa_Bruker_TEN_MIDIA_200ng_CE10_100ms_Slot1-9_1_488.d"

# accept_Bruker_EULA_and_on_Windows_or_Linux = TRUE
# if(accept_Bruker_EULA_and_on_Windows_or_Linux){
#     folder_to_stode_priopriatary_code = "/home/matteo"
#     path_to_bruker_dll = download_bruker_proprietary_code(folder_to_stode_priopriatary_code)
#     setup_bruker_so(path_to_bruker_dll)
#     all_columns = c('frame','scan','tof','intensity','mz','inv_ion_mobility','retention_time')
# } else {
#     all_columns = c('frame','scan','tof','intensity','retention_time')
# }
path_to_bruker_dll = "/home/matteo/libtimsdata.so"
x = setup_bruker_so(path_to_bruker_dll)

E = TimsR(path)

tdf.tables(E)
min_max_measurements(E)
?min_max_measurements
?rt_query

rt_query(E, 10, 20)

qplot_TIC(E)
E[100]
Y = E[1000:4000]
rm(Y)
cleanMem()



X = E[1:100, c('frame','scan','tof','retention_time','intensity','mz','inv_ion_mobility')]
rt_query(E, 10,12)

tables_names(E)
tdf.tables(E)

frames = table2dt(E,'Frames')



I = sapply(E@min_frame:E@max_frame,
           function(fr) sum(E[fr, c('intensity')]$intensity))

I2 = frames$SummedIntensities

.ms1_mask = frames$MsMsType == 0
plot(I-I2[.ms1_mask],I2[.ms1_mask])

RT = retention_times(D)

cleanMem()






X[,.(I=sum(intensity)), frame]

Y = query(E, 1000:4000)
Y[,.(I=sum(intensity)),frame]
cleanMem()



showMethods('[')

microbenchmark(
    D[100],
    E[100]
)

E[100]
E[1:100]

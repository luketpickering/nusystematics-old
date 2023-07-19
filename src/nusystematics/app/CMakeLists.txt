LIST(APPEND TARGETS_TO_BUILD 
GenerateSystProviderConfigNuSyst
)

foreach(targ ${TARGETS_TO_BUILD})
  add_executable(${targ} ${targ}.cxx)
  target_link_libraries(${targ} 
    systtools::utility
    systtools::interface
    nusyst::commondeps
    nusyst::interface
    nusyst::systproviders
    nusyst::utility
    nusyst::responsecalculators
    ${ROOT_LIBRARIES}
    #ROOT::Minuit
    ROOT::Geom
    #ROOT::EG
    #ROOT::EGPythia6
    #ROOT::GenVector
    ROOT::MathMore
  )

endforeach()

install(TARGETS ${TARGETS_TO_BUILD} DESTINATION bin/)

#pragma once

#include "systematicstools/interface/SystMetaData.hh"

#include "fhiclcppsimple/ParameterSet.h"

#include <string>

namespace nusyst {

systtools::SystMetaData
ConfigureQEParameterHeaders(fhiclsimple::ParameterSet const &, systtools::paramId_t,
                            fhiclsimple::ParameterSet &tool_options);

systtools::SystMetaData
ConfigureMECParameterHeaders(fhiclsimple::ParameterSet const &, systtools::paramId_t,
                            fhiclsimple::ParameterSet &tool_options);

systtools::SystMetaData
ConfigureNCELParameterHeaders(fhiclsimple::ParameterSet const &, systtools::paramId_t,
                              fhiclsimple::ParameterSet &tool_options);

systtools::SystMetaData
ConfigureRESParameterHeaders(fhiclsimple::ParameterSet const &, systtools::paramId_t,
                             fhiclsimple::ParameterSet &tool_options);
systtools::SystMetaData
ConfigureCOHParameterHeaders(fhiclsimple::ParameterSet const &, systtools::paramId_t,
                             fhiclsimple::ParameterSet &tool_options);

systtools::SystMetaData
ConfigureDISParameterHeaders(fhiclsimple::ParameterSet const &, systtools::paramId_t,
                             fhiclsimple::ParameterSet &tool_options);

systtools::SystMetaData
ConfigureFSIParameterHeaders(fhiclsimple::ParameterSet const &, systtools::paramId_t,
                             fhiclsimple::ParameterSet &tool_options);

systtools::SystMetaData
ConfigureOtherParameterHeaders(fhiclsimple::ParameterSet const &,
                               systtools::paramId_t);

} // namespace nusyst

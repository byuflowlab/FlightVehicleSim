"""
    An interactional aerodynamics and acoustics solver for multirotor aircraft
    and wind energy.

    * Main developers : Eduardo J. Alvarez (edoalvarez.com) and Ryan Anderson (rymanderson@gmail.com)
    * Email           : Edo.AlvarezR@gmail.com
    * Repo            : github.com/byuflowlab/FLOWUnsteady
    * Created         : Sep 2017
    * License         : MIT
"""
module FLOWUnsteady

# ------------ GENERIC MODULES -------------------------------------------------

using StaticArrays

# ------------ FLOW CODES ------------------------------------------------------

# NOTE: Unregistered packages available at https://github.com/byuflowlab
import BSON
import Dates
import FastMultipole as fmm
import FLOWVPM as vpm
import ForwardDiff
import VortexLattice as vlm
import VSPGeom as vsp
using WriteVTK
# import FLOWPanel

# Aliases
# const pnl   = FLOWPanel

# ------------ GLOBAL VARIABLES ------------------------------------------------

const module_path    = splitdir(@__FILE__)[1]              # Path to this module
const default_database  = joinpath(module_path, "..", "database") # Default path to database
const def_data_path  = default_database
const examples_path  = joinpath(module_path, "..", "examples") # Path to examples
const DEBUG = Array{Bool,0}(undef)
DEBUG[] = false

# ------------ HEADERS ---------------------------------------------------------

include("dummy_sixdof.jl")
export Quaternion, rotate, rotate_frame, DynamicState, DynamicStateDerivative

include("initializer.jl")
export AbstractInitializer, DefaultInitializer

include("dummy_flowtrajectories.jl")
export AbstractController, PrescribedKinematics, control!

include("freestream.jl")
export AbstractFreestream, SimpleFreestream

include("model.jl")
export AbstractModel, VortexLatticeModel

include("state.jl")
export AbstractState, RigidBodyState, set_substate!, set_dynamic_state_derivative!, reset_dynamic_state_derivative!, set_dynamic_state!, apply_force!, apply_moment!, quaternion_frame_2_top, transform_parent_2_top, set_position!, set_orientation!, visualize

include("vehicle.jl")
export AbstractVehicle, AbstractCoordinateSystem, Aerodynamics, FlightDynamics, RigidBodyVehicle, add_substate!, get_substate!

include("integrator.jl")
export AbstractTimeIntegrator, ForwardEuler

include("postprocessor.jl")
export AbstractPostprocessor, History, ParaviewOutput, MultiPostprocessor

include("simulation.jl")
export Simulation, AbstractPreprocessor, DefaultPreprocessor, AbstractPostprocessor, DefaultPostprocessor, simulate!

# VPM utilities
# include(joinpath(vpm.utilities_path, "utilities_fluiddomain.jl"))

end # END OF MODULE

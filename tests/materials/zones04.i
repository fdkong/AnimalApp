# insitu porosity zones only
# As ASCII art, the zones are:
#
# 23
# 12
#
[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 2
  xmin = 0
  xmax = 2
  ny = 2
  ymin = 0
  ymax = 2
[]


[GlobalParams]
  richardsVarNames_UO = PPNames
  density_UO = DensityConstBulk
  relperm_UO = RelPermPower
  SUPG_UO = SUPGnone
  sat_UO = Saturation
  seff_UO = SeffVG
  viscosity = 1E-3
[]

[UserObjects]
  [./PPNames]
    type = RichardsVarNames
    richards_vars = pressure
  [../]
  [./DensityConstBulk]
    type = RichardsDensityConstBulk
    dens0 = 1
    bulk_mod = 1.0E3
  [../]
  [./SeffVG]
    type = RichardsSeff1VG
    m = 0.8
    al = 1 # same deal with PETSc's "constant state"
  [../]
  [./RelPermPower]
    type = RichardsRelPermPower
    simm = 0.0
    n = 2
  [../]
  [./Saturation]
    type = RichardsSat
    s_res = 0.1
    sum_s_res = 0.1
  [../]
  [./SUPGnone]
    type = RichardsSUPGnone
  [../]
[]

[Variables]
  [./pressure]
  [../]
[]

[ICs]
  [./pressure]
    type = ConstantIC
    variable = pressure
    value = 1
  [../]
[]


[Kernels]
  [./richardst]
    type = RichardsMassChange
    variable = pressure
  [../]
[]

[AuxVariables]
  [./i_zone]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./ch_zone]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./kxx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./kxy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./kxz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./kyy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./kyz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./kzz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./por_zone]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./por]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [./i_zone]
    type = ConstantAux
    variable = i_zone
    value = 0
  [../]
  [./ch_zone]
    type = ConstantAux
    variable = ch_zone
    value = 0
  [../]
  [./por_zone]
    type = FunctionAux
    variable = por_zone
    function = 'x+y'
  [../]
  [./kxx]
    type = MaterialRealTensorValueAux
    variable = kxx
    property = permeability
    row = 0
    column = 0
  [../]
  [./kxy]
    type = MaterialRealTensorValueAux
    variable = kxy
    property = permeability
    row = 0
    column = 1
  [../]
  [./kxz]
    type = MaterialRealTensorValueAux
    variable = kxz
    property = permeability
    row = 0
    column = 2
  [../]
  [./kyy]
    type = MaterialRealTensorValueAux
    variable = kyy
    property = permeability
    row = 1
    column = 1
  [../]
  [./kyz]
    type = MaterialRealTensorValueAux
    variable = kyz
    property = permeability
    row = 1
    column = 2
  [../]
  [./kzz]
    type = MaterialRealTensorValueAux
    variable = kzz
    property = permeability
    row = 2
    column = 2
  [../]
  [./por]
    type = MaterialRealAux
    variable = por
    property = porosity
  [../]
[]

[Materials]
  [./rock]
    type = BAMaterial
    block = 0
    mat_porosity = 0.5
    mat_permeability = '0 0 0  0 0 0  0 0 0'
    gravity = '0 0 0'
    insitu_perm_zone = i_zone
    kh = 0
    kv = 0
    insitu_por_zone = por_zone
    por = '0.1 0.2 0.3 0.4'
    change_perm_zone = ch_zone
    change_kh = 0
    change_kv = 0
    linear_shape_fcns = true
  [../]
[]


[Preconditioning]
  [./andy]
    type = SMP
    full = true
    #petsc_options = '-snes_test_display'
    petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it'
    petsc_options_value = 'bcgs bjacobi 1E-15 1E-10 10000'
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1
  dt = 1
  solve_type = Newton
[]

[Outputs]
  execute_on = 'timestep_end'
  file_base = zones04
  [./exodus]
    type = Exodus
  [../]
[]

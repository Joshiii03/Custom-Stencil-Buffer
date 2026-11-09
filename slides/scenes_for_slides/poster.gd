extends Node3D
@onready var cpu_particles_3d = $StencilHolder1/CPUParticles3D
@onready var cpu_particles_3d_2 = $StencilHolder1/CPUParticles3D2
@onready var cpu_particles_3d_3 = $StencilHolder2/CPUParticles3D
@onready var cpu_particles_3d_4 = $StencilHolder2/CPUParticles3D2
@onready var cpu_particles_3d_6 = $StencilHolder2/CPUParticles3D3


func _ready():
	cpu_particles_3d.emitting = true
	cpu_particles_3d_2.emitting = true
	cpu_particles_3d_3.emitting = true
	cpu_particles_3d_4.emitting = true
	cpu_particles_3d_6.emitting = true

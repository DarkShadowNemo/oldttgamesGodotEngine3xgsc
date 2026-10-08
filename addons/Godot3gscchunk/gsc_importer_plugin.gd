tool
extends EditorImportPlugin
class_name gsc_model_

func unsigned16_to_signed16(value):
	value &= 0xFFFF
	if value & 0x8000:
		value -= 0x10000
	return value

func get_importer_name():
	return "gsc"
	
func get_visible_name():
	return "Finding Nemo GSC"
	
func get_recognized_extensions():
	return ["gsc"]

func get_priority():
	return 1.0
	
func get_import_order():
	return 0
	
func get_save_extension():
	return "mesh"
	
func get_resource_type():
	return "Mesh"

func get_preset_count():
	return 1
	
func get_preset_name(i):
	return "Default"
	
func get_import_options(preset):
	return []
	
	
func import(source_file, save_path, options, platform_variants, gen_files):
	var mesh = ArrayMesh.new()
	var arrays=[]
	arrays.resize(Mesh.ARRAY_MAX)
	
	var vertices = PoolVector3Array()
	var faces = PoolIntArray()
	var uvs = PoolVector2Array()
	var vcols = PoolColorArray()
	var fa=-1
	var fb=0
	var fc=1
	var f = File.new()
	f.open(source_file, File.READ)
	while f.get_position() < f.get_len():
		var Chunk = f.get_32()
		if Chunk == int(808605006):
			var primtype = f.get_32()
			if primtype == int(6):
				var padding01 = f.get_32()
			elif primtype != int(6):
				var primtype_ = f.get_32()
				var padding01_ = f.get_32()
		elif Chunk == int(1279415374):
			pass
		elif Chunk == int(810832724):
			var TextureFileSize = f.get_32()
			var TextureCount = f.get_32()
			var TexturePadding01 = f.get_32()
		elif Chunk == int(16777475):
			f.get_16()
			var vertexCount = f.get_8()
			var flag1 = f.get_8()
			if flag1 == int(104):
				pass
			elif flag1 == int(108):
				if vertexCount == int(0):
					pass
				elif vertexCount == int(1):
					pass
				elif vertexCount == int(2):
					pass
				elif vertexCount:
					for j in range(vertexCount):
						var vx = f.get_float()
						var vy = f.get_float()
						var vz = f.get_float()
						var faceon = f.get_8()
						var valon = f.get_8()
						var nz = f.get_16()
						var type4 = faceon==0
						vertices.append(Vector3(vx,vy,-vz))
						fa+=1
						fb+=1
						fc+=1
						if type4:
							faces.append_array([j+j+faceon-faceon-1+fa-j-j-1,j-j+faceon-faceon+1+fb-2-1,j+faceon-faceon+fc-j+2-4])
					var offset2 = f.get_16()
					if offset2 == int(32772):
						var uvcount = f.get_8()
						var flag2 = f.get_8()
						if flag2 == int(101):
							if uvcount == int(0):
								pass
							elif uvcount == int(1):
								pass
							elif uvcount == int(2):
								pass
							elif uvcount:
								for i in range(uvcount):
									var uvx = f.get_16()
									var uvy = f.get_16()
									var uvxs = unsigned16_to_signed16(uvx)
									var uvys = unsigned16_to_signed16(uvy)
									var uvxf = float(uvxs)/4096
									var uvyf = float(uvys)/4096
									uvs.append(Vector2(uvxf,-uvyf))
								var offset3 = f.get_16()
								if offset3 == int(0):
									f.get_32()
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
								elif offset3 == int(49157):
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
						elif flag2 == int(109):
							if uvcount == int(0):
								pass
							elif uvcount == int(1):
								pass
							elif uvcount == int(2):
								pass
							elif uvcount:
								for i in range(uvcount):
									var uvx = f.get_16()
									var uvy = f.get_16()
									f.get_32()
									var uvxs = unsigned16_to_signed16(uvx)
									var uvys = unsigned16_to_signed16(uvy)
									var uvxf = float(uvxs)/4096
									var uvyf = float(uvys)/4096
									uvs.append(Vector2(uvxf,-uvyf))
								var offset3 = f.get_16()
								if offset3 == int(0):
									f.get_32()
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
								elif offset3 == int(49157):
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
					elif offset2 == int(1):
						f.get_32()
						var uvcount = f.get_8()
						var flag2 = f.get_8()
						if flag2 == int(109):
							if uvcount == int(0):
								pass
							elif uvcount == int(1):
								pass
							elif uvcount == int(2):
								pass
							elif uvcount:
								for i in range(uvcount):
									var uvx = f.get_16()
									var uvy = f.get_16()
									f.get_32()
									var uvxs = unsigned16_to_signed16(uvx)
									var uvys = unsigned16_to_signed16(uvy)
									var uvxf = float(uvxs)/4096
									var uvyf = float(uvys)/4096
									uvs.append(Vector2(uvxf,-uvyf))
								var offset3 = f.get_16()
								if offset3 == int(0):
									f.get_32()
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
								elif offset3 == int(49157):
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
						elif flag2 == int(101):
							if uvcount == int(0):
								pass
							elif uvcount == int(1):
								pass
							elif uvcount == int(2):
								pass
							elif uvcount:
								for i in range(uvcount):
									var uvx = f.get_16()
									var uvy = f.get_16()
									var uvxs = unsigned16_to_signed16(uvx)
									var uvys = unsigned16_to_signed16(uvy)
									var uvxf = float(uvxs)/4096
									var uvyf = float(uvys)/4096
									uvs.append(Vector2(uvxf,-uvyf))
								var offset3 = f.get_16()
								if offset3 == int(0):
									f.get_32()
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
								elif offset3 == int(49157):
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
									
					elif offset2 == int(0):
						f.get_32()
						var uvcount = f.get_8()
						var flag2 = f.get_8()
						if flag2 == int(109):
							if uvcount == int(0):
								pass
							elif uvcount == int(1):
								pass
							elif uvcount == int(2):
								pass
							elif uvcount:
								for i in range(uvcount):
									var uvx = f.get_16()
									var uvy = f.get_16()
									f.get_32()
									var uvxs = unsigned16_to_signed16(uvx)
									var uvys = unsigned16_to_signed16(uvy)
									var uvxf = float(uvxs)/4096
									var uvyf = float(uvys)/4096
									uvs.append(Vector2(uvxf,-uvyf))
								var offset3 = f.get_16()
								if offset3 == int(0):
									f.get_32()
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
								elif offset3 == int(49157):
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
						elif flag2 == int(110):
							if uvcount == int(0):
								pass
							elif uvcount == int(1):
								pass
							elif uvcount == int(2):
								pass
							elif uvcount:
								for i in range(uvcount):
									var r1 = f.get_8()
									var g1 = f.get_8()
									var b1 = f.get_8()
									var a1 = f.get_8()
									vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
						elif flag2 == int(101):
							if uvcount == int(0):
								pass
							elif uvcount == int(1):
								pass
							elif uvcount == int(2):
								pass
							elif uvcount:
								for i in range(uvcount):
									var uvx = f.get_16()
									var uvy = f.get_16()
									var uvxs = unsigned16_to_signed16(uvx)
									var uvys = unsigned16_to_signed16(uvy)
									var uvxf = float(uvxs)/4096
									var uvyf = float(uvys)/4096
									uvs.append(Vector2(uvxf,-uvyf))
								var offset3 = f.get_16()
								if offset3 == int(0):
									f.get_32()
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
								elif offset3 == int(49157):
									var vcolCount = f.get_8()
									var flag3 = f.get_8()
									if flag3 == int(110):
										for i in range(vcolCount):
											var r1 = f.get_8()
											var g1 = f.get_8()
											var b1 = f.get_8()
											var a1 = f.get_8()
											vcols.push_back(Color(float(r1)/127,float(g1)/127,float(b1)/127,float(a1)/127))
					
	
	
	f.close()
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = faces
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_COLOR] = vcols
	
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	var filename = save_path + "." + get_save_extension()
	return ResourceSaver.save(filename, mesh)
	
	

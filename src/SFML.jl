module SFML

using Base.Libdl.dlsym

function load_libs()
	try
		global const libcsfml_graphics = Libdl.dlopen("libcsfml-graphics.2.2")
		global const libcsfml_window = Libdl.dlopen("libcsfml-window.2.2")
		global const libcsfml_network = Libdl.dlopen("libcsfml-network.2.2")
		global const libcsfml_system = Libdl.dlopen("libcsfml-system.2.2")
		global const libcsfml_audio = Libdl.dlopen("libcsfml-audio.2.2")
	catch Exception
		println("Something has gone wrong with the csfml installation. Please reinstall this package.")
		loaded = false
	end
end


@osx_only cd("$(Pkg.dir("SFML"))/deps/CSFML-2.2-osx/") do
	load_libs()
end

@linux_only cd("$(Pkg.dir("SFML"))/deps/CSFML-2.2-linux") do
	old_ldpath = ENV["LD_LIBRARY_PATH"]
	ENV["LD_LIBRARY_PATH"] = ".:$(old_ldpath)"
	load_libs()
	ENV["LD_LIBRARY_PATH"] = old_ldpath
end

cd("$(Pkg.dir("SFML"))/deps/") do
	global const libjuliasfml = Libdl.dlopen("libjuliasfml")
end

include("julia/Network/packet.jl")
include("julia/Network/ipAddress.jl")
include("julia/Network/socketStatus.jl")
include("julia/Network/tcpSocket.jl")
include("julia/Network/tcpListener.jl")

include("julia/System/vector.jl")
include("julia/System/time.jl")
include("julia/System/thread.jl")
include("julia/System/clock.jl")

include("julia/Audio/music.jl")
include("julia/Audio/soundBuffer.jl")
include("julia/Audio/sound.jl")

include("julia/Graphics/videoMode.jl")
include("julia/Graphics/image.jl")
include("julia/Graphics/color.jl")
include("julia/Graphics/font.jl")
include("julia/Graphics/text.jl")
include("julia/Graphics/rect.jl")
include("julia/Graphics/view.jl")
include("julia/Graphics/texture.jl")
include("julia/Graphics/sprite.jl")
include("julia/Graphics/convexShape.jl")
include("julia/Graphics/rectangleShape.jl")
include("julia/Graphics/circleShape.jl")

include("julia/Window/event.jl")

include("julia/Graphics/renderWindow.jl")

include("julia/Window/mouse.jl")
include("julia/Window/keyboard.jl")

end

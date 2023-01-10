include("${CMAKE_CURRENT_LIST_DIR}/configure_base.cmake")

# configuration_flag(VTK_DEFAULT_RENDER_WINDOW_OFFSCREEN "offscreen")
# configuration_flag(VTK_OPENGL_HAS_OSMESA "osmesa")
set(VTK_DEFAULT_RENDER_WINDOW_HEADLESS True CACHE BOOL "")
set(VTK_OPENGL_HAS_EGL False CACHE BOOL "")
set(VTK_OPENGL_HAS_OSMESA True CACHE BOOL "")
set(VTK_USE_COCOA False CACHE BOOL "")
set(VTK_USE_X False CACHE BOOL "")

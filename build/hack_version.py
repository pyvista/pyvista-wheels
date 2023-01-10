"""Manual patch to adjust version string.

See # https://gitlab.kitware.com/vtk/vtk/-/merge_requests/9674
"""
with open('setup.py', 'r') as f:
    content = f.read().replace(
        "version = version_base + '.dev0'",
        "version = version_base + '.' + os.environ.get('VTK_BUILD_VARIANT_SUFFIX', 'dev0')")
with open('setup.py', 'w') as f:
    f.write(content)

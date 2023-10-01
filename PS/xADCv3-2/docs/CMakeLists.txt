# region Doxygen

find_package(Doxygen REQUIRED)

set(DOXYGEN_EXTRACT_ALL YES)
set(DOXYGEN_BUILTIN_STL_SUPPORT YES)

set(DOXYGEN_GENERATE_HTML NO)
set(DOXYGEN_GENERATE_MAN NO)
set(DOXYGEN_GENERATE_XML YES)

set(DOXYGEN_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/doxygen")

doxygen_add_docs(doxygen
		../src
		../include)
# endregion

add_custom_target(sphinx-html
		COMMAND make clean
		COMMAND make html
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/sphinx"
		COMMENT "Build sphinx docs using doxygen xml as input"
		DEPENDS doxygen)

cmake_minimum_required(VERSION 3.0)
project(wstcollision VERSION 0.1.0)

include(GNUInstallDirs)

find_package(PkgConfig REQUIRED)
pkg_check_modules(CLANLIB REQUIRED clanCore-1.0 clanDisplay-1.0 clanGL-1.0 clanSignals-1.0 IMPORTED_TARGET)
add_executable(wstcollision
  src/main.cxx
  src/colltest.cxx
  src/collision.cxx)
target_link_libraries(wstcollision PkgConfig::CLANLIB)

install(TARGETS wstcollision
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# EOF #

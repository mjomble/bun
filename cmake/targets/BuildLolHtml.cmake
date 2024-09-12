include(Macros)
include(SetupRust)

register_repository(
  NAME
    lolhtml
  REPOSITORY
    cloudflare/lol-html
  COMMIT
    8d4c273ded322193d017042d1f48df2766b0f88b
)

set(LOLHTML_CWD ${CWD}/vendor/lolhtml/c-api)
set(LOLHTML_BUILD_PATH ${BUILD_PATH}/lolhtml)

if(DEBUG)
  set(LOLHTML_BUILD_TYPE debug)
else()
  set(LOLHTML_BUILD_TYPE release)
endif()

set(LOLHTML_LIBRARY ${LOLHTML_BUILD_PATH}/${LOLHTML_BUILD_TYPE}/${CMAKE_STATIC_LIBRARY_PREFIX}lolhtml${CMAKE_STATIC_LIBRARY_SUFFIX})

set(LOLHTML_BUILD_ARGS
  --target-dir ${BUILD_PATH}/lolhtml
)

if(RELEASE)
  list(APPEND LOLHTML_BUILD_ARGS --release)
endif()

register_command(
  TARGET
    lolhtml
  CWD
    ${LOLHTML_CWD}
  COMMAND
    ${CARGO_EXECUTABLE}
      build
      ${LOLHTML_BUILD_ARGS}
  ARTIFACTS
    ${LOLHTML_LIBRARY}
)

target_link_libraries(${bun} PRIVATE ${LOLHTML_LIBRARY})
if(BUN_LINK_ONLY)
  target_sources(${bun} PRIVATE ${LOLHTML_LIBRARY})
endif()
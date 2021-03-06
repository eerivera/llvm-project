Integration Tests
=====================
The implementation of libc-project is unique because our public C header files
are generated using information from TableGen. Unit tests only exercise the
internal C++ implementations and don't ensure the headers were generated by the
build system. End to end testing ensures that, after building, the produced
library and headers are usable in the C runtime. A simple solution is to have
contributors write an integration test for each individual function as a C
program; however, this would place a large burden on contributors and duplicates
some effort from the unit tests.

Instead we automate the generation of integration tests by modeling it from our
generated headers. These integration tests ensure that public facing symbols are
visible, that header files are generated as expected, and that each libc
function has the correct function prototype.

The integration test cmake rules are located in ``test/src/CMakeLists.txt`` and
the generated integration test lives in
``llvm/build/projects/libc/test/src/public_integration_test.cpp``

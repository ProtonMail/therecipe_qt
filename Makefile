TARGETS:=qtdeploy qtminimal qtmoc qtrcc qtsetup
INSTALL_PATH:=${GOPATH}/bin/

.PHONY: doc_deps build install clean

build: ${TARGETS}

doc_deps:
	go get github.com/therecipe/qt/internal/binding/files/docs/5.12.0
	go get github.com/therecipe/qt/internal/binding/files/docs/5.13.0
	go get github.com/therecipe/qt/internal/cmd/moc

qt%: cmd/qt% doc_deps
	go build -tags=no_env ./$<

install:
	mkdir -p ${INSTALL_PATH}
	rm -f $(addprefix ${INSTALL_PATH},${TARGETS})
	cp ${TARGETS} ${INSTALL_PATH}

clean: 
	rm ${TARGETS}

GHC = ghc
GUI = gui

%: %.hs
	$(GHC) $<

clean:
	@printf "Erasing compiled files..."
	@rm $(GUI) *.o *.hi
	@printf "\tdone\n"

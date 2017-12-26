GHC = ghc
BIN = gui

%: %.hs
	@$(GHC) $<

clean:
	@printf "Erasing compiled files..."
	@rm $(BIN) *.o *.hi
	@printf "done\n"

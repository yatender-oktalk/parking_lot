run:
	mix deps.get && mix compile && iex -S mix
	
test:
	mix deps.get && mix test

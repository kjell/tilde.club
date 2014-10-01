down:
	rsync -avz --progress kjell@tilde.club: .

up:
	rsync -avz --progress . kjell@tilde.club:

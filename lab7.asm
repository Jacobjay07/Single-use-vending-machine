# ------------------------------------
# Lab 7: Vending Machine
# ------------------------------------

#Just wanted to say I used ai to help me fix a bug that was
#Making my program crash, spefically "Segmentation fault (core dumped)
#Before using ai, I had this all done, it just didn't run fully and gave me
#an error

.intel_syntax noprefix

.data

#String constants

	CatNip:
		.asciz  "1. Cat Nip (85 cents)\n"



	StringItem:
		.asciz  "2. String (25 cents)\n"


	BouncyBall:
		.asciz "3. Bouncy Ball (60 cents)\n"


	CatSnacks:
		.asciz  "4. Cat Snacks (42 cents)\n"


	title:		.asciz "Fluff-a-matic Vending Machine\n"
	centsMsg: 	.asciz "How many cents were entered: "
	selectMsg: 	.asciz "Your selection: "
	changeMsg: 	.asciz "Your change is "
	centsWord: 	.asciz " cents\n"
	dispMsg: 	.asciz "Dispensing:\n"
	qtrLabel: 	.asciz " quarter(s)\n"
	dimeLabel: 	.asciz " dime(s)\n"
	nickLabel: 	.asciz " nickel(s)\n"
	penLabel: 	.asciz " penny(s)\n"
	insufFunds: 	.asciz "You have insufficient funds\n"

	Items:
		.quad CatNip
		.quad StringItem
		.quad BouncyBall
		.quad CatSnacks

	Costs:
		.quad 85
		.quad 25
		.quad 60
		.quad 42

#Declaring Integer Vriables


	 cents:
			.quad 0


	 choice:
			.quad 0


	 cost:
			.quad 0


	 change:
			.quad 0


	 quarters:
			.quad 0


	 dimes:
			.quad 0


	 nickels:
			.quad 0


	 pennies:
			.quad 0

.text
.global Program

Program:
#Display Item Menu

		lea rcx, title
		call PrintStrZ

		lea rcx, CatNip
		call PrintStrZ

		lea rcx, StringItem
		call PrintStrZ

		lea rcx, BouncyBall
		call PrintStrZ

		lea rcx, CatSnacks
		call PrintStrZ

#Get User Input


		lea rcx, centsMsg
		call PrintStrZ
		call ScanInt64
		mov cents, rcx

		lea rcx, selectMsg
		call PrintStrZ
		call ScanInt64
		mov choice, rcx


#Look Up Item Using Table


		mov rax, choice
		sub rax, 1

		mov rcx, [Items + rax * 8]
		call PrintStrZ

		mov rdx, [Costs + rax * 8]
		mov cost, rdx

#Calculate Change


		mov rcx, cents
		sub rcx, [cost]
		mov change, rcx

		cmp rcx, 0
		jl Insufficient

		lea rcx, changeMsg
		call PrintStrZ

		mov rcx, change
		call PrintInt64

		lea rcx, centsWord
		call PrintStrZ

		lea rcx, dispMsg
		call PrintStrZ


#Make Change (Integer Division)
MakeChange:

		mov rax, change
		mov rdx, 0
		mov rbx, 25

		idiv rbx

		mov quarters, rax
		mov change, rdx


		mov rax, change
		mov rdx, 0
		mov rbx, 10

		idiv rbx

		mov dimes, rax
		mov change, rdx


		mov rax, change
		mov rdx, 0
		mov rbx, 5

		idiv rbx

		mov nickels, rax
		mov change, rdx


#Display Coin Breakdown


		mov rcx, quarters
		call PrintInt64

		lea rcx, qtrLabel
		call PrintStrZ

		mov rcx, dimes
		call PrintInt64

		lea rcx, dimeLabel
		call PrintStrZ

		mov rcx, nickels
		call PrintInt64

		lea rcx, nickLabel
		call PrintStrZ

		mov rcx, change
		call PrintInt64

		lea rcx, penLabel
		call PrintStrZ

		jmp End

Insufficient:

		lea rcx, insufFunds
		call PrintStrZ


End:

		call ProgramEnd

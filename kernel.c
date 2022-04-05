
void clear()
{
	asm(".intel_syntax noprefix"
		"mov ah, 00h"
		"mov al, 03h"
		"int 10h"
	);
}

int main(int argc, char const *argv[])
{	
	clear();
	return 0;
}
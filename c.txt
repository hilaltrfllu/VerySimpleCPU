int main()
{
	int * led = 1024;
	int * sw = 1040;
	int * control_word = 1072;
	int * character_code = 1073;
	//int cursor_x=1074;
	//int cursor_y=1075;
	int i;
	int j;
	int k;
	int m;
	int n;
	int char_array[5];
	char_array[0]= 7;
	char_array[1]= 3;
	char_array[2]= 5;
	char_array[3]= 2;
	char_array[4]= 1;

	while(*control_word == 0){
	}
	*control_word = 7;
	for(n=0;n<5;n++){
        while(*control_word==0){
        }
        *character_code = char_array[i]+48;
        *control_word = 5;
	}

	/*while(1){
        *led = *sw; //read from switches and write to led
	}*/

	/*while (*control_word == 0){
	}
	* cursor_x = 1;
	* cursor_y = 5;
	* control_word = 7;
	for(e=0;e<5;e++){
		while(*control_word = 0){
		}
		*character_code = char_array[i]+48;
		*control_word = 5;
	}*/

	for(i=0; i<5; i++){
		for(k=0;k<5;k++){
            int temp;
            if(char_array[i] > char_array[i+1]){
                temp = char_array[i];
                char_array[i] = char_array[i+1];
                char_array[i+1] = temp;
            }
		}
	}

	for(m=0;m<5;m++){
		while(*control_word == 0){
		}
		*character_code = char_array[i]+48;
		*control_word = 5;
	}

	while(1){
		*led = *sw;
	}
	return 0;
}
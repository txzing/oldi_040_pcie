/*
 * user_app.h
 *
 *  Created on: 2024年6月26日
 *      Author: 13648
 */

#ifndef SRC_USER_APP_H_
#define SRC_USER_APP_H_

extern u32 ret32;
extern u8 ret8;

extern u8 cerrent_ch;
extern u8 key_flag;


void app_info(void);
void video_resolution_print(char *info,u32 baseaddr);
void uart_receive_process(void);

void MODS_Switch(void);
void Timing_fresh(void);

#endif /* SRC_USER_APP_H_ */

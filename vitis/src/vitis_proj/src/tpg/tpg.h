/*
 * tpg.h
 *
 *  Created on: Apr 30, 2021
 *      Author: andreas
 */

#ifndef _TPG_H_
#if defined (XPAR_XV_TPG_NUM_INSTANCES)
#define _TPG_H_

#include "xv_tpg.h"

void tpg_cfg(XV_tpg *InstancePtr, u32 height, u32 width, u32 colorFormat, u32 bckgndId);
void tpg_box(XV_tpg *InstancePtr, u32 boxSize, u32 motionSpeed);
#endif
#endif /* _TPG_H_ */

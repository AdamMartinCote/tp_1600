#ifndef CAR_H
#define CAR_H
#include <cstdlib>
#include <string>
#include <iostream>

/*
 * Base class for shapes.
 */
bool Equals(float a, float b);

class CCar {

public:

   /* Class constructor */
   CCar(float starting_position,float starting_speed,float starting_acceleration,float update_interval);

   /* Class destructor */
   virtual ~CCar();

   /* Verify C and ASM equivalence */
   virtual void VerifyCoherence() const;

   /* Print current status */
   virtual void PrintStatus() const;

   /* Calculates the car status after update_interval */
   virtual void UpdateStatusCpp();

   /* Calculates the car status after update_interval */
   virtual void UpdateStatusAsm();

   /* Calculates the average speed from the begin of the simulation */
   virtual float AverageSpeedCpp() const;

   /* Calculates the average speed from the begin of the simulation */
   virtual float AverageSpeedAsm() const;

   /* Calculates the total distance done from the begin of the simulation */
   virtual float TotalDistCpp() const;

   /* Calculates the total distance done from the begin of the simulation */
   virtual float TotalDistAsm() const;

   /* Calculates the constant acceleration that would have allowed to cover the
   same distance done in the same time while starting with a speed equal to 0*/
   virtual float EquivalentAccCpp() const;

   /* Calculates the constant acceleration that would have allowed to cover the
   same distance done in the same time while starting with a speed equal to 0*/
   virtual float EquivalentAccAsm() const;

private:

   /* The circle radius */
   float s0;						/* +4  */
   float v0;						/* +8  */
   float a0;						/* +12 */
   float st_c;						/* +16 */
   float vt_c;						/* +20 */
   float at_c;						/* +24 */
   float time_passed_c;				/* +28 */
   float st_asm;					/* +32 */
   float vt_asm;					/* +36 */
   float at_asm;					/* +40 */
   float time_passed_asm;			/* +44 */
   float interv;					/* +48 */
   float started;					/* +52 */
};

#endif

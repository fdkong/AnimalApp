
#ifndef LAPLACEYOUNG_H
#define LAPLACEYOUNG_H

#include "Kernel.h"

class LaplaceYoung;

template<>
InputParameters validParams<LaplaceYoung>();

class LaplaceYoung : public Kernel
{
public:
	LaplaceYoung(const InputParameters & parameters);

  virtual ~LaplaceYoung();

protected:
  virtual Real computeQpResidual();

  virtual Real computeQpJacobian();
};


#endif /* DIFFUSION_H */

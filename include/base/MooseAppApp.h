#ifndef MOOSE_APPAPP_H
#define MOOSE_APPAPP_H

#include "MooseApp.h"

class MooseAppApp;

template<>
InputParameters validParams<MooseAppApp>();

class MooseAppApp : public MooseApp
{
public:
  MooseAppApp(InputParameters parameters);
  virtual ~MooseAppApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* MOOSE_APPAPP_H */

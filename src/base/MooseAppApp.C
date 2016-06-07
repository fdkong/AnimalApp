#include "MooseAppApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

template<>
InputParameters validParams<MooseAppApp>()
{
  InputParameters params = validParams<MooseApp>();

  params.set<bool>("use_legacy_uo_initialization") = false;
  params.set<bool>("use_legacy_uo_aux_computation") = false;
  params.set<bool>("use_legacy_output_syntax") = false;

  return params;
}

MooseAppApp::MooseAppApp(InputParameters parameters) :
    MooseApp(parameters)
{
  Moose::registerObjects(_factory);
  ModulesApp::registerObjects(_factory);
  MooseAppApp::registerObjects(_factory);

  Moose::associateSyntax(_syntax, _action_factory);
  ModulesApp::associateSyntax(_syntax, _action_factory);
  MooseAppApp::associateSyntax(_syntax, _action_factory);
}

MooseAppApp::~MooseAppApp()
{
}

// External entry point for dynamic application loading
extern "C" void MooseAppApp__registerApps() { MooseAppApp::registerApps(); }
void
MooseAppApp::registerApps()
{
  registerApp(MooseAppApp);
}

// External entry point for dynamic object registration
extern "C" void MooseAppApp__registerObjects(Factory & factory) { MooseAppApp::registerObjects(factory); }
void
MooseAppApp::registerObjects(Factory & factory)
{
}

// External entry point for dynamic syntax association
extern "C" void MooseAppApp__associateSyntax(Syntax & syntax, ActionFactory & action_factory) { MooseAppApp::associateSyntax(syntax, action_factory); }
void
MooseAppApp::associateSyntax(Syntax & /*syntax*/, ActionFactory & /*action_factory*/)
{
}

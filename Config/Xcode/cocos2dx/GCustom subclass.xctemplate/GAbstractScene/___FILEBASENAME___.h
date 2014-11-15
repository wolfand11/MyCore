//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

#ifndef ___PROJECTNAMEASIDENTIFIER_______FILEBASENAMEASIDENTIFIER____H
#define ___PROJECTNAMEASIDENTIFIER_______FILEBASENAMEASIDENTIFIER____H

#include "GAbstractScene.h"
#define kGXXXLayerKey        "GXXXLayer"
#define kGYYYLayerKey        "GXXXLayer"

class ___FILEBASENAMEASIDENTIFIER___ : public ___VARIABLE_GCustomCocosSubclassOption___
{
public:
    ___FILEBASENAMEASIDENTIFIER___();
    virtual ~___FILEBASENAMEASIDENTIFIER___();
    
    virtual void RegisteLayerLoader(cocos2d::extension::CCNodeLoaderLibrary * ccNodeLoaderLibrary)
    {
        //ccNodeLoaderLibrary->registerCCNodeLoader(kGXXXLayerKey, GCustomLayerLoader<GXXXLayer>::loader());
    }
    virtual void EnterScene()
    {
		GLayersKeyVect toSomeLayer = { kGXXXLayerKey, kGYYYLayerKey };
        ResetSwitchDataStack(toSomeLayer);
    }

protected:

private:
    
};

#endif

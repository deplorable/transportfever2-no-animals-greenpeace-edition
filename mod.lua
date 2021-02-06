local vec3 = require "vec3"
require "tableutil"

local count = 1

-- From the Official Modding docs on Animals at https://www.transportfever2.com/wiki/doku.php?id=modding:animals
-- If an animal gets into an area with negative score, it will try to run away. 
-- If it fails to leave the non suitable area it will eventually die. 

local function modelModifier (fileName, data)
  -- encourage despawning of animals by hastening their death
  if data.metadata                       and
     data.metadata.animal                and
     data.metadata.animal.config         and
     data.metadata.animal.config.density
  then
    -- Reset density parameter.
    data.metadata.animal.config.density = 0;
    -- Make everywhere really undesirable
    data.metadata.animal.suitableAreas.scores.civilisation = -1000;
    data.metadata.animal.suitableAreas.scores.fish = -1000;
    data.metadata.animal.suitableAreas.scores.forest = -1000;
    data.metadata.animal.suitableAreas.scores.predator = -1000;
    data.metadata.animal.suitableAreas.scores.ship = -1000;
    data.metadata.animal.suitableAreas.scores.shore = -1000;
    data.metadata.animal.suitableAreas.scores.water = -1000;
    -- Stop animals from moving too far from where they spawned
    data.metadata.animal.config.targetDistance = 0;
    -- Make animals swim with the fishes, just like mobsters do with their victims!
    data.metadata.animal.config.fish = true;
  end
  return data
end
 
addModifier( "loadModel", modelModifier )

function data()
  return {
    info = {
      minorVersion = 1,
      severityAdd = "NONE",
      severityRemove = "NONE",
      name = _("name"),
      description = _("desc"),
      tags = { "Script Mod" },
      authors = {
        {
          name = "Dirkels",
          role = 'CREATOR',
          steamProfile = "Dirkels"
        },
        { 
          name = "c64gamer",
          role = 'CREATOR',
          steamProfile = "c64gamer"
        }
      }
    },

    runFn = function( settings )
      -- prevent spawning of animals.
      addModifier( "loadModel", function( fileName, data )
        if data.metadata                       and
           data.metadata.animal                and
           data.metadata.animal.config         and
           data.metadata.animal.config.density
        then
          -- Reset density parameter.
          data.metadata.animal.config.density = 0;
          -- Make everywhere really undesirable
          data.metadata.animal.suitableAreas.scores.civilisation = -1000;
          data.metadata.animal.suitableAreas.scores.fish = -1000;
          data.metadata.animal.suitableAreas.scores.forest = -1000;
          data.metadata.animal.suitableAreas.scores.predator = -1000;
          data.metadata.animal.suitableAreas.scores.ship = -1000;
          data.metadata.animal.suitableAreas.scores.shore = -1000;
          data.metadata.animal.suitableAreas.scores.water = -1000;
          -- Stop animals from moving too far from where they spawned
          data.metadata.animal.config.targetDistance = 0;
          -- Make animals swim with the fishes, just like mobsters do with their victims!
          data.metadata.animal.config.fish = true;
        end
        return data
      end)
    end
    
  }
end

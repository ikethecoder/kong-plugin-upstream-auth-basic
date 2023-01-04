local typedefs = require "kong.db.schema.typedefs"

-- Grab pluginname from module name
local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

local schema = {
  name = plugin_name,
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { username = {
              type = "string",
              required = true
            }
          },
          
          { password = {
              type = "string",
              required = false
            }
          }
        },
        entity_checks = {
        }
      },
    },
  },
}

return schema
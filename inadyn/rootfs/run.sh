#!/usr/bin/env bashio

# ==============================================================================
# Home Assistant Community Add-on: Base Images
# Displays a simple add-on banner on startup
# ==============================================================================
if bashio::supervisor.ping; then
    bashio::log.blue \
        '-----------------------------------------------------------'
    bashio::log.blue " Add-on: $(bashio::addon.name)"
    bashio::log.blue " $(bashio::addon.description)"
    bashio::log.blue \
        '-----------------------------------------------------------'

    bashio::log.blue " Add-on version: $(bashio::addon.version)"
    if bashio::var.true "$(bashio::addon.update_available)"; then
        bashio::log.magenta ' There is an update available for this add-on!'
        bashio::log.magenta \
            " Latest add-on version: $(bashio::addon.version_latest)"
        bashio::log.magenta ' Please consider upgrading as soon as possible.'
    else
        bashio::log.green ' You are running the latest version of this add-on.'
    fi

    bashio::log.blue " System: $(bashio::info.operating_system)" \
        " ($(bashio::info.arch) / $(bashio::info.machine))"
    bashio::log.blue " Home Assistant Core: $(bashio::info.homeassistant)"
    bashio::log.blue " Home Assistant Supervisor: $(bashio::info.supervisor)"

    bashio::log.blue \
        '-----------------------------------------------------------'
    bashio::log.blue \
        ' Please, share the above information when looking for help'
    bashio::log.blue \
        ' or support in, e.g., GitHub, forums or the Discord chat.'
    bashio::log.green \
        ' https://github.com/alexbelgium/hassio-addons'
    bashio::log.blue \
        '-----------------------------------------------------------'
fi

#################
# Create config #
#################
mustache-cli /data/options.json /templates/inadyn.mustache > /etc/inadyn.conf

##############
# Launch App #
##############
/usr/sbin/inadyn --foreground

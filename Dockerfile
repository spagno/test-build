FROM registry.redhat.io/rhel7:latest
USER root
# Copy entitlements
COPY ./etc-pki-entitlement /etc/pki/entitlement
# Copy repository configuration
COPY ./yum-repos-d /etc/yum.repos.d
COPY ./katello-server-ca/katello-server-ca.pem /etc/rhsm/ca/katello-server-ca.pem
# Delete /etc/rhsm-host to use entitlements from the build container
RUN rm /etc/rhsm-host && \
    # yum repository info provided by Satellite
    yum -y install nc && \
    # Remove entitlements
    rm -rf /etc/pki/entitlement
# OpenShift requires images to run as non-root by default
USER 1001
ENTRYPOINT ["while sleep 60; do : ; done"]

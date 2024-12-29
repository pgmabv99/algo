#include <stdio.h>
#include <spdk/env.h>
#include <spdk/nvme.h>

static _Bool
probe_cb(void *cb_ctx, const struct spdk_nvme_transport_id *trid,
         struct spdk_nvme_ctrlr_opts *opts)
{
    printf("Probing controller: %s\n", trid->traddr);
}

static void 
attach_cb(void *cb_ctx, const struct spdk_nvme_transport_id *trid,
          struct spdk_nvme_ctrlr *ctrlr, const struct spdk_nvme_ctrlr_opts *opts)
{
    const struct spdk_nvme_ctrlr_data *cdata;

    cdata = spdk_nvme_ctrlr_get_data(ctrlr);
    printf("Attached to controller: %s\n", trid->traddr);
    printf("Model Number: %s\n", cdata->mn);
    printf("Serial Number: %s\n", cdata->sn);

    // Perform further actions with the controller (e.g., reading/writing data)
}

int main(int argc, char **argv)
{
    struct spdk_env_opts opts;

    spdk_env_opts_init(&opts);
    opts.name = "spdk_sample";
    if (spdk_env_init(&opts) != 0) {
        fprintf(stderr, "Failed to initialize SPDK environment\n");
        return 1;
    }

    printf("SPDK environment initialized successfully\n");

    if (spdk_nvme_probe(NULL, NULL, probe_cb, attach_cb, NULL) != 0) {
        fprintf(stderr, "Failed to probe NVMe devices\n");
        spdk_env_fini();
        return 1;
    }

    printf("SPDK program completed\n");
    spdk_env_fini();
    return 0;
}
